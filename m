From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 4 Dec 2015 18:35:50 +0300
Subject: [RFC2 PATCH v6 00/19] ILP32 for ARM64
In-Reply-To: <20151203175955.GP10747@e104818-lin.cambridge.arm.com>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <20151203175955.GP10747@e104818-lin.cambridge.arm.com>
Message-ID: <20151204153550.GB1251@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 05:59:55PM +0000, Catalin Marinas wrote:
> On Wed, Nov 18, 2015 at 12:16:40AM +0300, Yury Norov wrote:
> >  - ILP32 VDSO code excluded. It's not mandatory, and caused questions
> >    during review process. We definitely make sure we will follow up
> >    with a VDSO later on because it is needed for performance reasons;
> 
> I already asked in one of the patches, don't you need a VDSO for
> sigreturn?
> 

I didn't realise it's mandatory for ARMv8 when removed it. I'll back
it, but I think rework required anyway.

> 
> Have you run any AArch32 LTP with these patches? The results should also
> be included in your table above.
> 

The full regression table is:
		ILP32		LP64            AARCH32 (v4.3 & v4.3 + ILP32)

float_bessel    FAIL	 134    PASSED	0       PASSED	0
float_exp_log   FAIL	 134    PASSED	0       PASSED	0
float_iperb     FAIL	 134    PASSED	0       PASSED	0
float_power     FAIL	 134    PASSED	0       PASSED	0
float_trigo     FAIL	 134    PASSED	0       PASSED	0
abort01         FAIL       2    FAIL 	2       FAIL 	2
fcntl14         FAIL       2    FAIL 	2       PASSED	0
kill11          FAIL       2    FAIL 	2       FAIL 	2
mmap16          FAIL       6    PASSED	0       PASSED	0
open12          FAIL       2    PASSED	0       PASSED	0
pause01         PASSED     0    FAIL 	9       FAIL 	9
pipe07          FAIL       2    PASSED	0       PASSED	0
readdir01       FAIL       1    PASSED	0       PASSED	0
rename11        FAIL       2    PASSED	0       PASSED	0
rmdir02         FAIL       2    PASSED	0       PASSED	0
setregid02      FAIL       1    FAIL 	1       PASSED	0
settimeofday01  FAIL       1    FAIL 	1       FAIL 	5
umount2_01      FAIL       2    PASSED	0       PASSED	0
umount2_02      FAIL       2    PASSED	0       PASSED	0
umount2_03      FAIL       2    PASSED	0       PASSED	0
utime06         FAIL       2    PASSED	0       PASSED	0

Fortunately, there's no aarch32 regression. Note that pause01 and
setregid02 are not stable. 
