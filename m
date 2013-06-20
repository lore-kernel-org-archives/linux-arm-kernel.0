From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 20 Jun 2013 20:29:30 +0100
Subject: [PATCH v2] ARM/KVM: save and restore generic timer registers
In-Reply-To: <20130620183221.GE4563@lvm>
References: <1370963819-26165-1-git-send-email-andre.przywara@linaro.org>
 <51C2D528.90805@arm.com> <20130620170923.GA4563@lvm>
 <51C339BD.2080600@arm.com> <20130620183221.GE4563@lvm>
Message-ID: <CAFEAcA97WiCYnSSs3utfq5+3tgausn+fjEnWeN6zj9sgP9P9qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 June 2013 19:32, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> Marc wrote:
>> So there is just one thing we absolutely need to make sure here: no vcpu
>> can run before they've all had their timer restored, and hence a stable
>> cntvoff. Otherwise two vcpus will have a different view of time.
>>
>> Can we guarantee this?

> Do we need to?  User space is free to modify time and all sort of other
> registers at any point during VM execution - it will just break the
> guest that it's running.

Note that QEMU will stop all CPUs before doing a migration or
similar operation. However there is a monitor command to query
the current CPU registers etc which won't try to stop the VM
first. So we might try to read vcpu registers (though I hope we
don't allow writing them).

-- PMM
