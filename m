From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 19 Apr 2015 18:59:45 +0200
Subject: [PATCH v2 1/8] ARM: replace PROCINFO embedded branch with
 relative offset
In-Reply-To: <1426248452-4773-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1426248452-4773-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426248452-4773-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAGhQ9VynJZWRb4iysXPE3X0GRaZNDNObz2Bgys01Kn7gjav7ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,
On 13 March 2015 at 13:07, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> This patch replaces the 'branch to setup()' instructions embedded
> in the PROCINFO structs with the offset to that setup function
> relative to the base of the struct. This preserves the position
> independent nature of that field, but uses a data item rather
> than an instruction.
>
> This is mainly done to prevent linker failures on large kernels,
> where the setup function is out of reach for the branch.

This commit (bf35706f3d09 in Linus master) breaks booting on ARMv7-M.

When I try to boot Linus master now on my NXP LPC4357 (Cortex-M4) dev
kit I get the following message from u-boot.
## Booting kernel from Legacy Image at 29000000 ...
Image Name: Linux
Image Type: ARM Linux Kernel Image (uncompressed)
Data Size: 1412318 Bytes = 1.3 MB
Load Address: 28008000
Entry Point: 28008001
Verifying Checksum ... OK
Loading Kernel Image ... OK
OK

Starting kernel ...

UNHANDLED EXCEPTION: HARD FAULT
R0 = ffffffff R1 = 00001038
R2 = 281d8711 R3 = 00000000
R12 = 2822092c LR = 28008023
PC = 2822092e PSR = 21000000

Reverting bf35706f3d09 (plus fixing a small conflict) makes Linus
master boot again.

I am using the following compiler:
gcc version 4.9.2 20140904 (prerelease) (crosstool-NG
linaro-1.13.1-4.9-2014.09 - Linaro GCC 4.9-2014.09

The ARMv7-M machine that I am using is not upstream yet, but you can
find the patch set on the mailing list.

regards,
Joachim Eastwood
