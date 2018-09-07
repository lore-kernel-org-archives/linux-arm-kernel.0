From: james.morse@arm.com (James Morse)
Date: Fri, 7 Sep 2018 10:57:06 +0100
Subject: [RESEND PATCH v4 0/6] arm64/mm: Move swapper_pg_dir to rodata
In-Reply-To: <20180822095432.12125-1-yaojun8558363@gmail.com>
References: <20180822095432.12125-1-yaojun8558363@gmail.com>
Message-ID: <3748f344-465e-63ee-8a9b-5ac1502163c2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jun,

(I'm a bit confused about which version of this series I should be looking at.
I have a v4, and two v4-resends, all of which are different. Please only mark
something as 'resend' if it is exactly the same!)


On 22/08/18 10:54, Jun Yao wrote:
> The set_init_mm_pgd() is reimplemented using assembly in order to
> avoid being instrumented by kasan.

There are some tidier ways of fixing this. The kasan init code is also C code
that is run before kasan is initialized. Kbuild is told not to let KASAN touch
it with 'KASAN_SANITISE_filename.o := n'.

But, in this case you're only calling into C code from pre-kasan head.S so you
can use the same helper to set init_mm.pgd. I don't think this is worth the
effort, we can just do the store in assembly. (more in patch 3).


Thanks,

James
