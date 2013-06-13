From: ming.lei@canonical.com (Ming Lei)
Date: Thu, 13 Jun 2013 10:25:10 +0800
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <alpine.LFD.2.02.1306120935320.22970@ionos>
References: <CACVXFVMNzwD44mhKijURSWrqLKjy7_oOY8hrTtjbyOxGS2tv=g@mail.gmail.com>
 <Pine.LNX.4.44L0.1306111431170.1392-100000@iolanthe.rowland.org>
 <CACVXFVPRWxjXqyv-L6yU1OLXHFYCbe7cQxGnaFxqbEXwBK=hfQ@mail.gmail.com>
 <alpine.LFD.2.02.1306120935320.22970@ionos>
Message-ID: <CACVXFVP__N9o3xRMd5+sk5T0zeGcrSk41rxY6Tzi1AM-mHL81Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 3:45 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 12 Jun 2013, Ming Lei wrote:
>
> Yes, please. I read through the thread and I really recommend that you
> get rid of the tasklet. tasklets are a complete disaster by design and
> we really should make efforts to get rid of the last users instead of
> trying to work around their semantical shortcomings.

The attached patch001 supports tasklet in HCD and patch002 implements
interrupt threaded handler, then if USB_HCD_THREADED_IRQ
is set, interrupt threaded handler is used to do URB giveback, otherwise
tasklet is used to do that.

The other 3 patches(2/4, 3/4, 4/4) aren't changed now, if anyone want to try it.
(the patch 2 is only for comparing performance difference, and welcome to
review/comment it so that we can get accurate test result to make decision)

Follows the mass storage test result(average over 10 times test) with
tasklet /interrupt threaded handler/hard interrupt handler under  same
environment of lenovo T410(x86), which means the test is switched by
reinserting module of usbcore or ehci-hcd without changing other things
in the machine.

- do below tests 10 times and figure out the average speed

          dd if=/dev/sdN of=/dev/null iflag=direct bs=200M 1

          device: sandisk extreme USB 3.0 16G, host: Lenovo T410 EHCI

- using interrupt threaded handler(default)
        33.440 MB/sec

- using tasklet(#undef USB_HCD_THREADED_IRQ)
        34.29 MB/sec

- using hard interrupt handler(by removing HCD_BH in ehci-hcd.c )
        34.260 MB/s


So looks usb mass storage performance loss can be observed with
interrupt threaded handler because one mass storage read/write sectors
requires at least 3 interrupts which wake up usb-storage thread 3 times
(each interrupt wakeup the usb-storage each time), introducing irq threaded
handler will make 2 threads to be waken up about 6 times for one read/write.

I think usb mass storage transfer handler need to be rewritten, otherwise
it may become worsen after using irq threaded handler in USB 3.0.(the
above device can reach >120MB/sec with hardware handler or tasklet handler,
which means about ~3K interrupts/sec, so ~6K contexts switch in case of
using irq threaded handler)

So how about supporting tasklet first, then convert to interrupt
threaded handler
after usb mass storage transfer is rewritten without performance loss?
(rewriting
usb mass storage transfer handler may need some time and work since storage
stability/correctness is extremely important, :-)

Also another problem with irq threaded handler is that there is no sort of
tasklet_schedule() interface to wakeup the thread handler manually, so
I have to use work to schedule some URB giveback from drivers(root hub
transfer, unlink),  even though that isn't a big deal but will cause code a bit
much/complicated, :-)

Thanks,
--
Ming Lei
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-USB-support-interrupt-threaded-handler.patch
Type: application/octet-stream
Size: 5752 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130613/50f04eb1/attachment-0002.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-USB-HCD-support-giveback-of-URB-in-tasklet-context.patch
Type: application/octet-stream
Size: 12423 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130613/50f04eb1/attachment-0003.obj>
