From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Mon, 16 Jan 2012 20:57:51 +0100
Subject: [PATCH v6 0/6] PM QoS: implement the OMAP low level constraints
 management code
In-Reply-To: <alpine.DEB.2.00.1112191337420.12660@utopia.booyaka.com>
References: <1323874304-5001-1-git-send-email-j-pihet@ti.com>
 <alpine.DEB.2.00.1112191337420.12660@utopia.booyaka.com>
Message-ID: <CAORVsuVNvvPu6it7r_uxc0f6H-9kpo6SChTTGkdqpLmzMDNxvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul, Kevin,

On Mon, Dec 19, 2011 at 10:02 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi Jean
>
> I'm really sorry it's taken me so long to do detailed review of these
> patches for merging... anyway -
>
> On Wed, 14 Dec 2011, jean.pihet at newoldbits.com wrote:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> . Implement the devices wake-up latency constraints using the global
>> ? device PM QoS notification handler which applies the constraints to the
>> ? underlying layer
>> . Implement the low level code which controls the power domains next power
>> ? states, through the hwmod and pwrdm layers
>> . Add cpuidle and power domains wake-up latency figures for OMAP3, cf.
>> ? comments in the code and [1] for the details on where the numbers
>> ? are magically coming from
>> . Implement the relation between the cpuidle and per-device PM QoS frameworks
>> ? in the OMAP3 specific idle callbacks.
>> ? The chosen C-state shall satisfy the following conditions:
>> ? ?. the 'valid' field is enabled,
>> ? ?. it satisfies the enable_off_mode flag,
>> ? ?. the next state for MPU and CORE power domains is not lower than the
>> ? ? ?state programmed by the per-device PM QoS.
>
> I've been reviewing these closely. ?It looks to me that are some issues
> that need to be resolved before all of them are mergeable.
>
> One issue that I noticed in this series is that there are some locking
> issues in patch 1. ?It looks to me that calls to
> _pwrdm_wakeuplat_update_pwrst() can race with each other, since it's
> called outside the lock?
I fixed this by moving the lock so that it includes the update of the
next power state.

Speaking of the locking, currently a spinlock is used and it could be
replaced by a more efficient mutex. This is ok at the condition that
this code is not called from interrupt context?

Kevin,
Do you know if the per-device constraint code can be called from
interrupt context?

>

...

>
>
> - Paul

Jean
