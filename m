From: james.hogan@imgtec.com (James Hogan)
Date: Tue, 8 Mar 2016 14:35:32 +0000
Subject: Build regressions/improvements in v4.5-rc7
In-Reply-To: <CAMuHMdWe9bTjp-qmTJc9=n9-iP-qH8-O0jafiRD3-y_EtT=WvA@mail.gmail.com>
References: <1457340934-23042-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdWe9bTjp-qmTJc9=n9-iP-qH8-O0jafiRD3-y_EtT=WvA@mail.gmail.com>
Message-ID: <20160308143532.GN31414@jhogan-linux.le.imgtec.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 07, 2016 at 10:01:09AM +0100, Geert Uytterhoeven wrote:
> On Mon, Mar 7, 2016 at 9:55 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > JFYI, when comparing v4.5-rc7[1] to v4.5-rc6[3], the summaries are:
> >   - build errors: +8/-7
>   + error: debugfs.c: undefined reference to `clk_round_rate':  =>
> .text+0x11b9e0)
> 
> arm-randconfig
> 
> While looking for more context, I noticed another regression that fell through
> the cracks of my script:
> 
>     arch/arm/kernel/head.o: In function `stext':
>     (.head.text+0x40): undefined reference to `CONFIG_PHYS_OFFSET'
>     drivers/built-in.o: In function `v4l2_clk_set_rate':
>     debugfs.c:(.text+0x11b9e0): undefined reference to `clk_round_rate'
> 
>   + error: misc.c: undefined reference to `ftrace_likely_update':  =>
> .text+0x714), .text+0x94c), .text+0x3b8), .text+0xc10)
> 
> sh-randconfig
> 
>     arch/sh/boot/compressed/misc.o: In function `lzo1x_decompress_safe':
>     misc.c:(.text+0x3b8): undefined reference to `ftrace_likely_update'
>     misc.c:(.text+0x714): undefined reference to `ftrace_likely_update'
>     misc.c:(.text+0x94c): undefined reference to `ftrace_likely_update'
>     arch/sh/boot/compressed/misc.o: In function `unlzo.constprop.2':
>     misc.c:(.text+0xc10): undefined reference to `ftrace_likely_update'
> 
>   + /tmp/cc52LvuK.s: Error: can't resolve `_start' {*UND* section} -
> `L0^A' {.text section}:  => 41, 403
>   + /tmp/ccHfoDA4.s: Error: can't resolve `_start' {*UND* section} -
> `L0^A' {.text section}:  => 43
>   + /tmp/cch1r0UQ.s: Error: can't resolve `_start' {*UND* section} -
> `L0^A' {.text section}:  => 49, 378
>   + /tmp/ccoHdFI8.s: Error: can't resolve `_start' {*UND* section} -
> `L0^A' {.text section}:  => 43
> 
> mips-allnoconfig
> bigsur_defconfig
> malta_defconfig
> cavium_octeon_defconfig
> 
> Not really new, but it would be great if the MIPS people could get this
> fixed for the final release.

This would appear to be related to the ld version check for VDSO
failing.

awk: /home/kisskb/slave/src/scripts/ld-version.sh: line 4: regular expression compile failed (missing '(')
.*)
/bin/sh: 1: [: -lt: unexpected operator

I.e. this line:
gsub(".*)", "");

appears to be trying to turn e.g. "GNU ld (Gentoo 2.25.1 p1.1) 2.25.1"
into " 2.25.1", so perhaps the bracket should be escaped. What version
of awk is it using? (GNU Awk 4.0.2 works for me).

Can somebody experiencing this please try:
${CROSS_COMPILE}ld --version | ./scripts/ld-version.sh

with the following patch, to see if it helps.

Thanks
James

diff --git a/scripts/ld-version.sh b/scripts/ld-version.sh
index 198580d245e0..1659b409ef10 100755
--- a/scripts/ld-version.sh
+++ b/scripts/ld-version.sh
@@ -1,7 +1,7 @@
 #!/usr/bin/awk -f
 # extract linker version number from stdin and turn into single number
 	{
-	gsub(".*)", "");
+	gsub(".*\\)", "");
 	split($1,a, ".");
 	print a[1]*10000000 + a[2]*100000 + a[3]*10000 + a[4]*100 + a[5];
 	exit
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160308/a7317b4c/attachment.sig>
