From: slash.tmp@free.fr (Mason)
Date: Mon, 22 Jun 2015 11:51:50 +0200
Subject: Seeking advice for first driver
Message-ID: <5587DAB6.4010307@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

I am writing my first Linux device driver from scratch, using LDD3
as a reference (waiting eagerly for LDD4). I've made some choices
that /seem/ good to me, but I don't see them in other drivers,
so I suspect I might be missing obvious pitfalls! I'd appreciate
if you could point them out :-)

I'm using Linux 3.14.44

About the device (smart card reader)

Communication with a smart card is serial (one bit a time), half duplex
(no simultaneous rx and tx) and slow-ish (typically 100 to 500 kbps).

I implemented read and write file operations.

A) write() as a blocking call; it returns control to user-space after
the last byte has been transmitted by the HW (which transmits even
if no smart card is present). The hardware provides a 16-byte TX FIFO,
so the transmit algorithm is simply:

  fill the TX FIFO, wait for TX DONE IRQ, repeat as needed.


static ssize_t scard_write(struct file *fp, const char __user *buf, size_t len, loff_t *pos)
{
  unsigned int res = 0;

  if (!ICC_PRESENT) return -ENODEV;
  if (!access_ok(VERIFY_READ, buf, len)) return -EFAULT;

  while (res < len) {
    int tile_size = min(len-res, 16u);
    if (write_tx_fifo(buf+res, tile_size)) return -EFAULT;
    res += tile_size;
    wait_for_completion(&done);
  }

  return res;
}

static int write_tx_fifo(const void __user *buf, int len)
{
  int i; u8 temp[16];
  if (__copy_from_user(temp, buf, len)) return -EFAULT;
  local_irq_disable();
  for (i = 0; i < len; ++i) writel_relaxed(temp[i], TX_BYTE);
  local_irq_enable();
  return 0;
}


NOTES:

I copy the tiles to a temporary kernel buffer because AFAIU,
__copy_from_user() may sleep, and I must not sleep with IRQs
disabled; IRQs have to be disabled while I copy data to the
FIFO because if the process is preempted, the FIFO might drain
prematurely, and assert a spurious IRQ (this is a hardware
limitation, the problem is fixed in the next revision).

What can cause __copy_from_user() to fail?
(Even when access_ok(VERIFY_READ, buf, len) succeeded.)

I used an uninterruptible wait because I didn't want to have
to cleanup in the process thread, and copying 16 bytes to the
FIFO takes a very short time (less than 500 ns; could use
word writes to cut it to even less)


B) read() as a "semi-blocking" call
The hardware supports arming a timer that is automatically reset
when a new character is received. So read() receives data from
the smart card until either the user's request is satisfied, or
10 ms have elapsed without any data from the smart card.

NOTES

I use a circular buffer to temporarily store the data sent by
the smart card.

I used a simple int to notify the interrupt handler that the
process thread is waiting for a signal to proceed, so that the
process thread only wakes up when it supposed to.


#define RX_BUF_SIZE   (1<<10)
#define RX_BUF_LEVEL  WRAP(head-tail)
#define WRAP(N)       ((N) & (RX_BUF_SIZE-1))

static u8 rx_buf[RX_BUF_SIZE];
static volatile unsigned int head, tail, req;
static DECLARE_COMPLETION(done);

static ssize_t scard_read(struct file *fp, char __user *buf, size_t len, loff_t *pos)
{
  unsigned int len0, len1, len2;

  if (!ICC_PRESENT) return -ENODEV;
  if (!access_ok(VERIFY_WRITE, buf, len)) return -EFAULT;

  if (RX_BUF_LEVEL < len) {
    req = len;
    ENABLE_TIMEOUT;
    wait_for_completion(&done);
  }

  /** Circular buffer may wrap-around **/
  len0 = min(RX_BUF_LEVEL, len);
  len1 = min(RX_BUF_SIZE - tail, len0);
  len2 = len0 - len1;
  if (__copy_to_user(buf,      rx_buf+tail, len1)) return -EFAULT;
  if (__copy_to_user(buf+len1, rx_buf,      len2)) return -EFAULT;
  tail = WRAP(tail + len0);
  return len0;
}


The ISR is called with local irqs disabled, right?
=> request_irq(SCARD_IRQ, scard_isr, 0, "scard", NULL);

static irqreturn_t scard_isr(int irq, void *dev_id)
{
  u32 irqs = readl_relaxed(IRQS);
  writel_relaxed(irqs, IRQS);
  if (irqs & TX_IRQ) complete(&done);
  if (irqs & RX_IRQ) read_rx_fifo(0);
  if (irqs & TO_IRQ) read_rx_fifo(1);
  return IRQ_HANDLED;
}

static void read_rx_fifo(int timeout)
{
  while (RX_FIFO_DEPTH > 0) {
    rx_buf[head] = readl_relaxed(RX_BYTE);
    head = WRAP(head+1);
  }
  if (req && (timeout || RX_BUF_LEVEL >= req)) {
    req = 0;
    DISABLE_TIMEOUT;
    complete(&done);
  }
}


AFAICT, there are no problematic races...

Anyway, if anyone's read this far, well thanks first of all ;-)
If you have advice, comments, suggestions, I'd love to hear them.

Regards.
