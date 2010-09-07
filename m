From: ww-ml@gmx.de (Wolfgang Wegner)
Date: Tue, 7 Sep 2010 18:11:57 +0200
Subject: Kirkwood PCI(e) write performance and DMA engine support for
	copy_{to, from}_user?
In-Reply-To: <AANLkTi=Mgzw9m+KiyzG7sHqD=mv1Q6WZXqMn_s_+p6Oq@mail.gmail.com>
References: <20100906100244.GA6897@debian-wegner1.datadisplay.de>
	<20100906140347.GA24522@n2100.arm.linux.org.uk>
	<20100906141444.GD6897@debian-wegner1.datadisplay.de>
	<AANLkTimqiAuv9XiU55VBxfPO6HZXCs5d9pshS3XDwsFc@mail.gmail.com>
	<AANLkTi=Mgzw9m+KiyzG7sHqD=mv1Q6WZXqMn_s_+p6Oq@mail.gmail.com>
Message-ID: <20100907161156.GA3625@debian-wegner1.datadisplay.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Saeed,

On Tue, Sep 07, 2010 at 12:52:39PM +0300, saeed bishara wrote:
> On Tue, Sep 7, 2010 at 10:58 AM, saeed bishara <saeed.bishara@gmail.com> wrote:
> > On Mon, Sep 6, 2010 at 5:14 PM, Wolfgang Wegner <ww-ml@gmx.de> wrote:
> >> On Mon, Sep 06, 2010 at 03:03:47PM +0100, Russell King - ARM Linux wrote:
> >>> On Mon, Sep 06, 2010 at 12:02:44PM +0200, Wolfgang Wegner wrote:
> >>> > Mapping the PCI memory space via mmap() resulted in some
> >>> > disappointing ~6.5 MBytes/second. I tried to modify page
> >>> > protection to pgprot_writecombine or pgprot_cached, but while
> >>> > this did reproducably change performance, it was only in
> >>> > some sub-percentage range. I am not sure if I understand
> >>> > correctly how other framebuffers handle this, but it seems
> >>> > the "raw" mmapped write performance is not cared about too
> >>> > much or maybe not that bad with most x86 chip sets?
> >>> > However, the idea left over after some trying and looking
> >>> > around is to use the DMA engine to speed up write() (and
> >>> > also read(), but this is not so important) system calls
> >>> > instead of using mmap.
> >>>
> >>> Framebuffer applications such as Xorg/Qt do not use read/write calls
> >>> to access their buffers because that will be painfully slow.
> >>
> >> BTW, the throughput I get with a "dd if=bitmap of=/dev/fb0 bs=512"
> >> is the same I get from my test application writing longwords
> >> sequentially to the mmapped frame buffer.
> > I'm not sure the writecombine is enabled properly, can you test that on DRAM?
> > you can do that be reserving some memory (mem=<dram size - 8M>), then
> > try to test throughput with and without writecombine.
> >
> also, in order to sent bursts, make sure that the stm instruction is
> used, preferred with 8 registers with address aligned to 8*4 bytes.

thanks for your hints and patience!

I am not sure if I did things correctly. I set up an 8MB mapping
from system RAM as you proposed, and am getting 240 MBytes/second
write data rate with a simple test application filling the whole
region with 0x12345678 mapped through my driver.

In the driver, I used the following combinations for ioremap and
pgprot modification during remap_pfn_range:
ioremap_wc + pgprot_writecombine(vma->vm_page_prot)
ioremap_cached + <no modification of vma->vm_page_prot>
ioremap_nocache + pgprot_noncached(vma->vm_page_prot)

In contrast to my previous test, I could not see even a minimal
reproducible difference between any of the tests, the absolute
values of "time" varied only between 0.033 and 0.035 statistically.
(around 1.299 for writing to my PCI device's memory in the same
test)

However, I am not getting the writes to use the stm instruction,
so maybe this is the real limitation.
Here is my very basic test program:

#define MEMSIZE 0x800000

int main() {
  int fbfd;
  unsigned long *fbp, *sfbp;
  unsigned long i;
  unsigned long fill_val = 0x12345678;

  fbfd = open("/dev/fb0", O_RDWR);
  if (!fbfd) {
    printf("Error: cannot open framebuffer device.\n");
    exit(1);
  }
  fbp = (unsigned long *)mmap(0, MEMSIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
                              fbfd, 0);
  sfbp = fbp;
  if(!fbp) {
    printf("Error: cannot mmap framebuffer\n");
    exit(1);
  }
#if 0
  for (i = 0; i < (MEMSIZE / 4); i += 8) {
    *(fbp + i) = fill_val;
    *(fbp + i + 1) = fill_val;
    *(fbp + i + 2) = fill_val;
    *(fbp + i + 3) = fill_val;
    *(fbp + i + 4) = fill_val;
    *(fbp + i + 5) = fill_val;
    *(fbp + i + 6) = fill_val;
    *(fbp + i + 7) = fill_val;
  }
#else
  for (i = MEMSIZE/32; i; i--) {
    *(fbp++) = fill_val;
    *(fbp++) = fill_val;
    *(fbp++) = fill_val;
    *(fbp++) = fill_val;
    *(fbp++) = fill_val;
    *(fbp++) = fill_val;
    *(fbp++) = fill_val;
    *(fbp++) = fill_val;
  }
#endif
  munmap(sfbp, MEMSIZE);
  close(fbfd);
  return 0;
}

Neither of the cases results in stm being used, all use
str.
(I am not so deep into assembler, let alone ARM assembler,
so please bear with my ignorance about what stm is or does
for now...)

I compiled with CodeSourcery arm-2010q1 toolchain with these
settings:
arm-none-linux-gnueabi-gcc -O3  -DARM -std=gnu99 -fgnu89-inline -Wall -Wno-format -pedantic

Could you provide any hint what I could do to get the
compiler to use stm?

Regards,
Wolfgang
