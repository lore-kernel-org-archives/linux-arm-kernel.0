From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 Aug 2017 17:19:57 +0100
Subject: [PATCH] scripts: make extract-vmlinux support armel/armhf
In-Reply-To: <CAEQ9gEmBv-fb2MbedSzs+dWtrq-ChXwiMrisyofZ7zfu+jADYA@mail.gmail.com>
References: <20170831153631.31026-1-rogershimizu@gmail.com>
 <20170831154941.GS20805@n2100.armlinux.org.uk>
 <CAEQ9gEmBv-fb2MbedSzs+dWtrq-ChXwiMrisyofZ7zfu+jADYA@mail.gmail.com>
Message-ID: <20170831161957.GU20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 01, 2017 at 01:05:16AM +0900, Roger Shimizu wrote:
> Dear Russell,
> 
> Thanks for your review!
> 
> On Fri, Sep 1, 2017 at 12:49 AM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Fri, Sep 01, 2017 at 12:36:31AM +0900, Roger Shimizu wrote:
> >> vmlinux/zImage on armel/armhf seems not an ELF, so update the script
> >> scripts/extract-vmlinux to support such case.
> >>
> >> This fix is tested on Debian amd64, armel, and armhf platform, with
> >> Debian kernels.
> >>
> >> Fixes: 09d481270d44 ("scripts: add extract-vmlinux")
> >> Cc: Corentin Chary <corentincj@iksaif.net>
> >> Cc: Michal Marek <mmarek@suse.com>
> >> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> >> Cc: Russell King <linux@arm.linux.org.uk>
> >> Cc: linux-arm-kernel at lists.infradead.org
> >> Cc: linux-kbuild at vger.kernel.org
> >> Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
> >> ---
> >>
> >> Dear Michal, Masahiro-san, and Russell,
> >>
> >> I posted this patch before [0] but didn't get positive response.
> >> Recently when I trace a Debian kernel issue, I still find this patch
> >> useful to locate the root cause [1].
> >>
> >> Besides, it's a well known bug confuses other developers [2][3].
> >> So I decide to submit the patch again.
> >>
> >> [0]: https://patchwork.kernel.org/patch/8120831/
> >> [1]: https://bugs.debian.org/870185#50
> >> [2]: https://bugs.launchpad.net/linaro-ubuntu/+bug/1050453
> >> [3]: https://bugs.linaro.org/show_bug.cgi?id=461
> >>
> >> Please kindly help to review. Thank you!
> >
> > I don't think this makes sense.  This script claims to extract a "vmlinux"
> > from a compressed kernel image.  "vmlinux" is normally the term of the
> > ELF object, and indeed as the script currently stands, it always guarantees
> > to output an ELF file.
> 
> If you think creating a new "scripts/extract-zImage" file is more
> proper way, we can do it.
> 
> > However, ARM zImage does not store a compressed ELF object, it stores a
> > compressed binary image of the executable in memory, so what you get out
> > of this script is not an ELF file, but the binary image (iow, what
> > arch/arm/boot/Image is.)
> >
> > What's the use case - what are you using the output of this script with?
> 
> I already provided a use case, to trace a Debian kernel issue caused
> by kernel size.
> - https://bugs.debian.org/870185#50

Sorry, I haven't time to look - it needs me to use firefox on a
different machine.  Maybe you could help by providing some details
by email, otherwise I've got extra work to do at some point in the
future (probably days away) if I remember (your mail will get buried).
Much of my time is in front of a _textual_ _only_ interface, and elinks
does not work with several modern SSL-only sites.

> I also see other people complaining this issue:
>  - https://bugs.launchpad.net/linaro-ubuntu/+bug/1050453
>  - https://bugs.linaro.org/show_bug.cgi?id=461
> 
> By a random web search, I find another blog post on how to dissamble the kernel.
>  - https://blog.packagecloud.io/eng/2016/03/08/how-to-extract-and-disassmble-a-linux-kernel-image-vmlinuz/

Yea, all SSL sites, I'm not going to try elinks with them, I don't
have the time to mess around.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
