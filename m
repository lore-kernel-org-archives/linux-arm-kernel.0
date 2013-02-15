From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Feb 2013 11:13:06 +0000
Subject: [PATCH 8/9] [HACK] ARM: imx: work around v7_cpu_resume link error
In-Reply-To: <201302151105.14253.arnd@arndb.de>
References: <1360882071-4072668-1-git-send-email-arnd@arndb.de>
 <1360882071-4072668-9-git-send-email-arnd@arndb.de>
 <511D7701.8040809@wwwdotorg.org> <201302151105.14253.arnd@arndb.de>
Message-ID: <20130215111306.GM17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 11:05:14AM +0000, Arnd Bergmann wrote:
> $ size  obj-tmp/vmlinux -A
> obj-tmp/vmlinux  :
> section                  size         addr
> .head.text                504   3221258240
> .text                32707336   3221258752
> .text.head                  8   3253966088

Interesting... I wonder if that should be .head.text, or maybe just .text.
Looking at iMX, it's just the secondary startup, which is calling into
.head.text, so it would be much safer given the size of the .text segment
for it to be in .head.text.

> The .text section alone is just short of 32MB.

I suspect when it does go over that, we'll see a lot more link time
failures due to the 'bl' instructions failing to encode their PC relative
jumps.  The only solution then will be to switch everything to use the
less efficient long jumps (load address from literal pool, bx) which'll
also need much of the asm changed.  That also brings up the question
whether we want to penalize the kernel performance just to make
allyesconfig work... I guess we can make it a compile time option, which
of course allyesconfig will automatically enable.  I suspect we'll see
a lot of people mistakenly enabling it too though.
