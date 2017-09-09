From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Sep 2017 15:27:53 +0100
Subject: [PATCH] scripts: make extract-vmlinux support armel/armhf
In-Reply-To: <CAEQ9gEmBv-fb2MbedSzs+dWtrq-ChXwiMrisyofZ7zfu+jADYA@mail.gmail.com>
References: <20170831153631.31026-1-rogershimizu@gmail.com>
 <20170831154941.GS20805@n2100.armlinux.org.uk>
 <CAEQ9gEmBv-fb2MbedSzs+dWtrq-ChXwiMrisyofZ7zfu+jADYA@mail.gmail.com>
Message-ID: <20170909142753.GB20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 01, 2017 at 01:05:16AM +0900, Roger Shimizu wrote:
> On Fri, Sep 1, 2017 at 12:49 AM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
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

Knowing the decompressed kernel image size alone is not sufficient
to guarantee that a kernel can boot, since both the decompressed and
compressed kernel images must be in memory together.

The temptation (as can be seen from kexec tooling) is to take the
size of the compressed image and allow for a 4x expansion of that
image, forgetting that the compressed image needs to remain available
during the decompression stage.  Hence, kexec was fixed to assume
that 5x the compressed kernel image size would be needed for the
kernel to successfully boot.

As far as I'm aware, that fixed the problem and no one has since
shown that it fails.  This simple method should also work without
needing to resort to extracting the compressed image.

Now, we do store the decompressed image size within the compressed
image (it's at the end of the compressed image) but it's very fiddly
to get to - there is other data after the end of the compressed image
which is of variable length, and although we have a header on the
compressed kernel which tells us the end of its own data, we have no
way to know how far back from the end of the image that size
information is stored.

This is a tad annoying, but it is the result of "evolution" rather
than explicit design - and this is why kexec tooling has had to
resort to the 5x heuristic.

> I also see other people complaining this issue:
>  - https://bugs.launchpad.net/linaro-ubuntu/+bug/1050453
>  - https://bugs.linaro.org/show_bug.cgi?id=461

These URLs are identical to those which you listed in your first
email.  All of them do not say why people want to do this, only
that they're trying to do it and it doesn't work.

In my first reply to you, I explicitly asked for use cases.  That
means providing the reason why the feature is necessary, and what
it is being used for, not providing evidence that folk want to do
it.

Having a "want" is not the same as explaining "why" something is
required.

> By a random web search, I find another blog post on how to dissamble the kernel.
>  - https://blog.packagecloud.io/eng/2016/03/08/how-to-extract-and-disassmble-a-linux-kernel-image-vmlinuz/

This is a great example which backs up _my_ assertion below:

> > and here you always pass '1', thereby bypassing the ELF check for every
> > architecture.  What if some architecture stores another compressed
> > object in the same compressed image?  I suspect the check is there to
> > ensure that it works on architectures where the compressed kernel image
> > contains other compressed objects.

The "blog.packagecloud.io" blog entry you've pointed at gives an
example of how to extract the *ELF object* from the compressed
kernel image and then run objdump on it.

As I've already explained, "vmlinux" is the name of the ELF kernel
image, and the script is called "extract-vmlinux".  Ergo, the
script is used to extract the ELF kernel image from a compressed
kernel image.  That is its purpose.  The resulting image should be
acceptable to objdump to disassemble.

So, even if the extract-vmlinux script were to be modified in the
way you want, the rest of the blog post is irrelevant, because the
resulting output from the modified script would produce a non-ELF
object and the following steps given there would fail.

So I repeat my questions:

1. what is the use case?

2. what use is the output of this script put to?

   (for the above two questions, I want to know what user*s* (plural)
    are wanting this script to do and what purpose they're putting it
    to.)

3. what impact does this modification have to other architectures
   which may be using this script?

4. is it safe to modify the script to provide the first compressed
   object whatever it may be rather than the first compressed ELF
   object?

And some new questions:

5. what about other scripts using extract-vmlinux which then go on
   to expect the output of the script to be an ELF file?

6. should the script _on ARM only_ turn the zImage back into an ELF
   file suitable for other tooling, so the script provides an
   identical experience for all architectures?

7. have these modifications been tested with other architecture's
   kernel images to confirm that it doesn't cause a regression for
   existing users?

Here's a much wider question: with the advent of KASLR for ARM, should
we store a partially linked kernel ELF image within the zImage instead
of a fully linked image, and then have a minimal linker as part of
the zImage decompressor to link the ELF image for the randomized
address?  If we did that, then the existing script would just work for
ARM.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
