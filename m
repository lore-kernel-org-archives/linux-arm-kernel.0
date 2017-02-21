From: broonie@kernel.org (Mark Brown)
Date: Tue, 21 Feb 2017 09:28:31 -0800
Subject: master build: 2 failures 0 warnings (v4.10-1215-g2bfe01e)
In-Reply-To: <E1cg4SU-0001er-8p@optimist>
References: <E1cg4SU-0001er-8p@optimist>
Message-ID: <20170221172831.lhei7zjzmcgpcjd5@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2017 at 07:01:59AM +0000, Build bot for Mark Brown wrote:

The build failures in arm and arm64 allmodconfigs that I reported in
-next last week are still present and now also appear in mainline:

> 	arm64-allmodconfig
> ../kernel/sched/core.c:198:25: error: 'paravirt_steal_rq_enabled' undeclared (first use in this function)
> ../kernel/sched/core.c:199:11: error: implicit declaration of function 'paravirt_steal_clock' [-Werror=implicit-function-declaration]
> 
> 	arm-allmodconfig
> ../kernel/sched/core.c:198:25: error: 'paravirt_steal_rq_enabled' undeclared (first use in this function)
> ../kernel/sched/core.c:199:11: error: implicit declaration of function 'paravirt_steal_clock' [-Werror=implicit-function-declaration]

This is due to 004172bdad64432 (sched/core: Remove unnecessary #include
headers).  asm/paravirt.h was one of the removed headers, it must be
included implicitly on x86 but clearly isn't on at least the two ARM
architectures and definitions from it are used directly.  I've sent a
patch, I'll resend.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170221/49e5ff7e/attachment.sig>
