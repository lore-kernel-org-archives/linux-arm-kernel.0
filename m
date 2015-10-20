From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Oct 2015 20:40:18 +0100
Subject: vmalloc_reserve with no highmem
In-Reply-To: <562696B4.7060600@gmail.com>
References: <56257AA5.1030800@gmail.com> <56268D82.7030504@redhat.com>
 <56269367.2000304@gmail.com>
 <20151020192554.GZ32532@n2100.arm.linux.org.uk>
 <562696B4.7060600@gmail.com>
Message-ID: <20151020194018.GA32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 12:32:04PM -0700, Florian Fainelli wrote:
> On 20/10/15 12:25, Russell King - ARM Linux wrote:
> > On Tue, Oct 20, 2015 at 12:17:59PM -0700, Florian Fainelli wrote:
> >> On 20/10/15 11:52, Laura Abbott wrote:
> >>> On 10/19/2015 04:20 PM, Florian Fainelli wrote:
> >>>> Hi Russell, Laura,
> >>>>
> >>>> Setting vmalloc= on the kernel command-line to define the amount of
> >>>> vmalloc_reserve is not quite working when you have no highmem, as is the
> >>>> case of one my boards which has 512MB or 256M populated on a first bank
> >>>> at PA 0x0.
> >>>>
> >>>> What happens in that case is that, despite setting vmalloc_reserve,
> >>>> therefore bumping up vmalloc_min to a higher address than high_memory,
> >>>> which is assigned __va(arm_lowmem_limit), we end-up with VMALLOC_START
> >>>> at high_memory + VMALLOC_OFFSET, which yields the amount of physical
> >>>> memory (start at PA 0x0 in my case) - VMALLOC_OFFSET.
> >>>>
> >>>> The maths look like this for this particular board (512MB)
> >>>>
> >>>> high_memory = 0x20000000 + PAGE_OFFSET = 0x20000000 + 0xC0000000 =
> >>>> 0xE0000000
> >>>> vmalloc_min = 0xFF00000 - (248 * 1024 * 1024) = 0xEF800000
> >>>>
> >>>> so we end-up with VMALLOC_START = high_memory + VMALLOC_OFFSET =
> >>>> 0xE0000000 + 8 * 1024* 1024 = 0xE0800000
> > 
> > Correct, high_memory will be 0xe0000000, which will set VMALLOC_START
> > to 0xe0800000, and you'll have lots of vmalloc space available.  That's
> > intentional.
> > 
> > vmalloc= sets the _minimum_ vmalloc space that's available, not the
> > absolute amount of space.
> 
> I think we need to update Documentation/kernel-parameters.txt then:
> 
> """
>         vmalloc=nn[KMG] [KNL,BOOT] Forces the vmalloc area to have an exact
>                         size of <nn>. This can be used to increase the
>                         minimum size (128MB on x86). It can also be used to
>                         decrease the size and leave more room for directly
>                         mapped kernel RAM.
> """
> 
> this makes me understand I should get the absolute value I specified.

It's not very well worded, but:

"This can be used to increase the minimum size" is the applicable part
here.  On ARM we follow x86.

> Might just be documentation vs. actual results displayed by the "Kernel
> virtual memory layout". A similar "issue" exists if you specify vmalloc=
> on the command-line and you get a result which is offset by VMALLOC_OFFSET.
> 
> I will do a better homework and go back to thinking about this.

x86 also has an 8MB hole.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
