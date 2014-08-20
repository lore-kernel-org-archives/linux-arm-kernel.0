From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 20 Aug 2014 15:16:23 +0100
Subject: [PATCH] Arm64: convert soft_restart() to assembly code
In-Reply-To: <CAFdej00s9ZYXnE4AfU0vUqTb4dmUg4U=fOhc3KS1_JK+0=+mdw@mail.gmail.com>
References: <1407847365-10873-1-git-send-email-achandran@mvista.com>
 <1408123221.22761.38.camel@smoke>
 <20140815182157.GD21908@leverpostej>
 <CAFdej01kDMSTpzdGiRmX8g=E4mZU2_5oiiKzyQ_z7z1jxeCF-A@mail.gmail.com>
 <20140820105408.GG21174@leverpostej>
 <CAFdej00s9ZYXnE4AfU0vUqTb4dmUg4U=fOhc3KS1_JK+0=+mdw@mail.gmail.com>
Message-ID: <20140820141623.GF21734@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> I am trying to kexec a UP-LE kernel from and SMP-LE kernel.
> 
> > As I mentioned we do need to ensure that the CPUs are in the mode they
> > started in, though I'm not sure I follow what you mean by "not waiting".
> > This could be an orthogonal issue.
> 
> If I verify the secondary CPUs from u-boot I can see that
> they are all looping at
> 
>     Core number       : 1
>     Core state        : debug (AArch64 EL2)
>     Debug entry cause : External Debug Request
>     Current PC        : 0x0000000000000238
>     Current CPSR      : 0x200003c9 (EL2h)
> 
> But after the kexec calls soft_restar(0) for all secondary CPUs
> they are looping at
> 
>     Core number       : 1
>     Core state        : debug (AArch64 EL1)
>     Debug entry cause : External Debug Request
>     Current PC        : 0xffffffc000083200
>     Current CPSR      : 0x600003c5 (EL1h)
> 
> This is what I mean by they are not waiting for
> the secondary start-up address to jump.

Ok.

> >
> > What exactly do you see, do the CPUs leave the spin-table, are they
> > taking exceptions, are they getting stuck in the spin-table, etc?
> >
> They all are clearly resetting to address "0"(Put a breakpoint and
> verified) but somehow they end up @0xffffffc000083200.
> I still don't know why.
> 
> ########
> ffffffc00008319c:       d503201f        nop
>         ...
> ffffffc000083200:       14000260        b       ffffffc000083b80 <el1_sync>
> ffffffc000083204:       d503201f        nop
> ffffffc000083208:       d503201f        nop
> ########

That's the EL1 exception vector table.

What looks to be happening is that something causes the CPUs to take an
exception (at EL1). Because translation isn't enabled and the vector
address doesn't map to anything, they'll take some sort of exception.
Because the vectors aren't mapped that will go recursive.

Your spin-table implementation might be poking something that's not
accessible at EL1, in which case you require the jump to EL2 for
correctness. I can't say for certain either way.

Thanks,
Mark.
