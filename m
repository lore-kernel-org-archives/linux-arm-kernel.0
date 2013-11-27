From: mingo@kernel.org (Ingo Molnar)
Date: Wed, 27 Nov 2013 12:27:32 +0100
Subject: [PATCH v2] use -fstack-protector-strong
In-Reply-To: <20131126203727.GA352@www.outflux.net>
References: <20131126203727.GA352@www.outflux.net>
Message-ID: <20131127112731.GA10435@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Kees Cook <keescook@chromium.org> wrote:

> On a defconfig x86_64 build (with CONFIG_CC_STACKPROTECTOR enabled), the
> delta in size is just under 9% larger:
> 
>  -rwxrwxr-x 1 kees kees  22134340 Nov 26 10:28 vmlinux.gcc-4.8
>  -rwxrwxr-x 1 kees kees  22123870 Nov 26 10:40 vmlinux.gcc-4.9
>  -rwxrwxr-x 1 kees kees  24225118 Nov 26 10:42 vmlinux.gcc-4.9+strong

Please run it through 'size' so that we know the real text size 
increases.

If the cost of -fstack-protector-strong is really +9% in kernel text 
size then that's rather significant!

If this option blows up our performance critical codepaths as well 
then this will likely cause a runtime slowdown as well, in addition to 
the increase in I$ footprint. That needs to be measured.

CONFIG_CC_STACKPROTECTOR=y is relatively cheap today. For example on 
x86-64 defconfig:

      text    data    bss     dec       filename
  11378972    1455056 1191936 14025964  vmlinux  # CONFIG_CC_STACKPROTECTOR is not set
  11420243    1455056 1191936 14067235  vmlinux  CONFIG_CC_STACKPROTECTOR=y

that's a +0.3% cost currently.

Thanks,

	Ingo
