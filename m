From: cdall@linaro.org (Christoffer Dall)
Date: Thu, 2 Feb 2017 16:08:44 +0100
Subject: [RFC v3 00/10] Provide the EL1 physical timer to the VM
In-Reply-To: <CAHyh4xhsqS6CijRysFvg+NqGo0rBQU45OhAaZUuHDm4M0JufTg@mail.gmail.com>
References: <1485970990-13775-1-git-send-email-jintack@cs.columbia.edu>
 <20170202123104.GJ27852@cbox>
 <CAHyh4xhsqS6CijRysFvg+NqGo0rBQU45OhAaZUuHDm4M0JufTg@mail.gmail.com>
Message-ID: <CAMJs5B89qBe9NRULeFeVxH6f=BQ-NdEE+1i2DhYJwEmJtZe9mQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 2, 2017 at 3:51 PM, Jintack Lim <jintack@cs.columbia.edu> wrote:
> On Thu, Feb 2, 2017 at 7:31 AM, Christoffer Dall <cdall@linaro.org> wrote:
>> Hi Jintack,
>>
>> On Wed, Feb 01, 2017 at 12:43:00PM -0500, Jintack Lim wrote:
>>> The ARM architecture defines the EL1 physical timer and the virtual timer,
>>> and it is reasonable for an OS to expect to be able to access both.
>>> However, the current KVM implementation does not provide the EL1 physical
>>> timer to VMs but terminates VMs on access to the timer.
>>>
>>> This patch series enables VMs to use the EL1 physical timer through
>>> trap-and-emulate.  The KVM host emulates each EL1 physical timer register
>>> access and sets up the background timer accordingly.  When the background
>>> timer expires, the KVM host injects EL1 physical timer interrupts to the
>>> VM.  Alternatively, it's also possible to allow VMs to access the EL1
>>> physical timer without trapping.  However, this requires somehow using the
>>> EL2 physical timer for the Linux host while running the VM instead of the
>>> EL1 physical timer.  Right now I just implemented trap-and-emulate because
>>> this was straightforward to do, and I leave it to future work to determine
>>> if transferring the EL1 physical timer state to the EL2 timer provides any
>>> performance benefit.
>>>
>>> This feature will be useful for any OS that wishes to access the EL1
>>> physical timer. Nested virtualization is one of those use cases. A nested
>>> hypervisor running inside a VM would think it has full access to the
>>> hardware and naturally tries to use the EL1 physical timer as Linux would
>>> do. Other nested hypervisors may try to use the EL2 physical timer as Xen
>>> would do, but supporting the EL2 physical timer to the VM is out of scope
>>> of this patch series. This patch series will make it easy to add the EL2
>>> timer support in the future, though.
>>>
>>> Note that Linux VMs booting in EL1 will be unaffected by this patch series
>>> and will continue to use only the virtual timer and this patch series will
>>> therefore not introduce any performance degredation as a result of
>>> trap-and-emulate.
>>>
>>> v2 => v3:
>>>  - Rebase on kvmarm/queue
>>>  - Take kvm->lock to synchronize cntvoff across all vtimers
>>>  - Remove unnecessary function parameters
>>>  - Add comments
>>
>> I just gave v3 a test run on my TC2 (32-bit platform) and my guest
>> quickly locks up trying to run cyclictest or when booting the machine it
>> stalls with RCU timeouts.
>
> Ok. It's my fault not to specify that the emulated physical timer is
> supported/tested on arm64.
> On 32-bit platform, it is supposed to show the same behavior as
> before, but I haven't tested.
> Were you using the physical timer or the virtual timer for the guest?
>

I used the same guest and QEMU that I always test with so I expect it
to only use the virtual timer.

I wonder if we can somehow manage to not reset the timer properly on
the 32-bit side and end up in a form of endless interrupt loop?

>>
>> Could you have a look?
>
> Sure, I'll have a look. I don't have access to my Cubietruck today,
> but I can work on that tomorrow.
>
ok, thanks.

-Christoffer
