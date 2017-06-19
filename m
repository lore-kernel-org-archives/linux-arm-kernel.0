From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Jun 2017 18:13:05 +0100
Subject: [PATCH] arm64: Decode information from ESR upon mem faults
In-Reply-To: <1497446043-50944-1-git-send-email-julien.thierry@arm.com>
References: <1497446043-50944-1-git-send-email-julien.thierry@arm.com>
Message-ID: <20170619171305.GA12786@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 02:14:03PM +0100, Julien Thierry wrote:
> When receiving unhandled faults from the CPU, description is very sparse.
> Adding information about faults decoded from ESR.
> 
> Added defines to esr.h corresponding ESR fields. Values are based on ARM
> Archtecture Reference Manual (DDI 0487B.a), section D7.2.28 ESR_ELx, Exception
> Syndrome Register (ELx) (pages D7-2275 to D7-2280).
> 
> New output is of the form:
> [  122.109118] Mem abort info:
> [  122.111884]   Exception class = DABT (current EL)
> [  122.116564]   IL = 32 bits
> [  122.119242]   SET = 0
> [  122.121507]   FnV = 0
> [  122.123754]   EA = 0
> [  122.125928]   S1PTW = 0
> [  122.128347] Data abort info:
> [  122.131212]   ISS[23:14] invalid

Is it still worth printing the ISS value here? I'm wondering about the
case where an old kernel runs on a new CPU and gets an abort that was
previously undefined.

> [  122.134417]   CM = 0
> [  122.136589]   WnR = 1

Hmm, this might get really confusing if multiple CPUs end up with their
prints interleaved. Perhaps having a print_unhandled_fault_info helper that
takes a prefix string (e.g. "Unhandled fault") and constructs the
information on one line would be preferable?

Then again, you could make the same argument about multi-line register
dumps, so perhaps I'm worrying too much here. Thoughts?

Will
