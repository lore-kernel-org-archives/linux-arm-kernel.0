From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 23 Apr 2012 16:49:32 +0100
Subject: [PATCH V2] watchdog: mpcore: Add DT probing support for ARM mpcore
 watchdog
In-Reply-To: <CAOh2x=n5Zm9MR5twDY-CUA-ppE9ADXrg25XCT5RKM++v6=tcpA@mail.gmail.com>
References: <18a4584c24041ceb8a1972dd5ee70cf7c59fed21.1334932839.git.viresh.kumar@st.com>
 <7dbd64f72527cf92af0ec38f45275d71207d5ec5.1335008301.git.viresh.kumar@st.com>
 <4F9514AA.10403@arm.com>
 <CAOh2x=kroSi8MZBhYVOhrDm08q1B9LS_9P7NPAfHC01-MHaOCQ@mail.gmail.com>
 <4F9547E3.4000709@arm.com>
 <CAOh2x=kQvjP5SYfJsTXkZyNe3UsS-=pXUBKoQ=SsMUNcPGjzuA@mail.gmail.com>
 <4F9573B8.9050607@arm.com>
 <CAOh2x=n5Zm9MR5twDY-CUA-ppE9ADXrg25XCT5RKM++v6=tcpA@mail.gmail.com>
Message-ID: <4F957A0C.7060607@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/04/12 16:33, viresh kumar wrote:
> On 4/23/12, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 23/04/12 15:21, viresh kumar wrote:
>>> On 4/23/12, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>> Ah, that explains why it worked. I suppose you do have additional
>>>> patches that fix the IRQ request bit?
>>>
>>> Missed this earlier. That patchset is in review currently and have
>>> already fixed that. :)
>>
>> Right. Please post that patch as a prerequisite for any other change.
> 
> Haah!! I misread your question. I don't know how, but i thought you are
> asking me to fix this address for SPEAr (My SoC). And that patch set
> is currently in review.
> 
> I didn't get this IRQ request bit thing? Can you please explain.

The TWD watchdog uses a per-cpu interrupt (usually interrupt #30), and
the GIC configuration should flag it as such. With this setup,
request_irq() should fail, and the right API is request_percpu_irq(),
together with enable_percpu_irq()/disable_percpu_irq().

So how it works in your environment is a bit puzzling. Unless you're not
using GIC?

	M.
-- 
Jazz is not dead. It just smells funny...
