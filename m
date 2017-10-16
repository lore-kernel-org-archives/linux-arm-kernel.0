From: gengdj.1984@gmail.com (gengdongjiu)
Date: Mon, 16 Oct 2017 11:17:32 +0800
Subject: [PATCH v3 15/20] KVM: arm64: Set an impdef ESR for Virtual-SError
 using VSESR_EL2.
In-Reply-To: <0184EA26B2509940AA629AE1405DD7F2016959EE@DGGEMA503-MBX.china.huawei.com>
References: <0184EA26B2509940AA629AE1405DD7F2016959EE@DGGEMA503-MBX.china.huawei.com>
Message-ID: <CAMj-D2BbOJBOUnY5r6mGUBB34Lq_z6xGAhvHyuNFjp29KLif7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> In fact I have below method for that, what do you think about that?
>
> 1.  If there is no RAS, old method, directly inject virtual SError, not need to specify ESR, as shown in the [1]
> 2.  If there is RAS, KVM set "the kvm_run" guest exit type value to let user space handle the SError abort
>    A. If ESR_EL2 is IMPLEMENTATION or uncategorized, return " ESR_ELx_ISV " to let user space specify an implementation-defined value, as shown [2]
>    B. If ESR_EL2 is categorized and error not propagated,  the error come from guest user space, return " (ESR_ELx_AET_UCU | ESR_ELx_FSC_SERROR " to let user space specify a recoverable ESR.
>      Here one side calling memory failure, another side let user pace inject SError. Because usually SEI notification does not deliver SIGBUS signal to user space, so here inject virtual SEI to ensure that. As shown [3]
>    C. If ESR_EL2 is categorized and error not propagated,  the error come from guest kernel, return "-1" to terminate guest. As shown [4]
>    D. Otherwise, Panic host OS. As shown [5]
>

For the IMPLEMENTATION ESR, for the safety purposes, I have below suggestion

1. When there is no guest,  host OS receives IMPLEMENTATION ESR, I
hope host can be panic, because we do not know its implementation
meaning.
2. when guest received MPLEMENTATION  ESR, and the Error is isolated
to guest by "ESB" instruction, not propagate to host. I hope guest
will exit, but host not panic.
3. when guest received MPLEMENTATION  ESR, and the Error is propagate
to host, I hope host can be panic.
