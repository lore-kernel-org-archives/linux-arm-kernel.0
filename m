From: danielmicay@gmail.com (Daniel Micay)
Date: Fri, 19 May 2017 19:57:07 -0400
Subject: stackprotector: ascii armor the stack canary
In-Reply-To: <20170519212636.30440-1-riel@redhat.com>
References: <20170519212636.30440-1-riel@redhat.com>
Message-ID: <1495238227.1190.1.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-05-19 at 17:26 -0400, riel at redhat.com wrote:
> Zero out the first byte of the stack canary value on 64 bit systems,
> in order to prevent unterminated C string overflows from being able
> to successfully overwrite the canary, even if an attacker somehow
> guessed or obtained the canary value.
> 
> Inspired by execshield ascii-armor and PaX/grsecurity.
> 
> Thanks to Daniel Micay for extracting code of similar functionality
> from PaX/grsecurity and making it easy to find in his linux-hardened
> git tree on https://github.com/thestinger/linux-hardened/

To clarify something this part isn't from PaX / grsecurity. I marked the
commits from PaX / grsecurity as such in their commit messages and these
are among the ones that aren't from there.

This is from a set of changes that I did for CopperheadOS and forward
ported to mainline recently to start linux-hardened. It was only arm64
for CopperheadOS. The overlap with PaX is that when adding the leading
zero byte for x86, I needed to first fix get_random_int being used for
the per-task canary value. I didn't know PaX fixed it way back in 2007.

I implemented heap canaries for our userspace malloc implementation and
then later did the same thing for slub in the kernel. I added a leading
zero byte to both of those heap canaries later on and then did the SSP
implementation in Bionic and the kernel's arm64 code. I took the idea
from glibc but limited it to 64-bit where there's entropy to spare. The
glibc leading zero might have come from execshield, but I don't know.
