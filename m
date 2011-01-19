From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 19 Jan 2011 17:32:33 +0000
Subject: [PATCH 1/3] Support BE8 mode kernel modules relocation
In-Reply-To: <AANLkTiktrCOxOH30ooM_Z=ct=cR5z49DiB+P4mqzi55E@mail.gmail.com>
References: <1295253729-23153-1-git-send-email-stanley.miao@windriver.com>
	<1295253729-23153-2-git-send-email-stanley.miao@windriver.com>
	<AANLkTi=RSpXHRpoZJsGLhVgQ=E=tcNGm8GXYC9UPaDrA@mail.gmail.com>
	<AANLkTi=q=e03GhmNZypGa5na2OiAr8SAOtiXm=+NPq5t@mail.gmail.com>
	<AANLkTi=F8_Zmm4OM2=JPMzSWbm0-Nyr4mxSPUNpdBg3N@mail.gmail.com>
	<AANLkTiktrCOxOH30ooM_Z=ct=cR5z49DiB+P4mqzi55E@mail.gmail.com>
Message-ID: <1295458353.13373.37.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-01-19 at 06:21 +0000, Stanley.Miao wrote:
> 2011/1/18 Catalin Marinas <catalin.marinas@arm.com>:
> > BTW (not related to modules, but since you are looking at this), when
> > we copy the sigreturn_codes to the vectors page in early_trap_init(),
> > do they get there in little endian form (as required by BE8)?
> 
> No, they get there in big endian.They are read as data in the function
> setup_return().
> 
> retcode = KERN_SIGRETURN_CODE + (idx << 2) + thumb;

This retcode here is an address in the vectors page which is set to LR
when invoking the signal handler. All fine here.

But the sigreturn_codes array contains instructions which get copied to
the vectors page in the early_trap_init() function. This array has this
instructions in big endian format but they should be converted to little
endian when copied to the vectors page.

-- 
Catalin
