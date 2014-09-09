From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 9 Sep 2014 08:17:50 -0600
Subject: [PATCH v10 07/10] OF: Introduce helper function for getting PCI
 domain_nr
In-Reply-To: <3780051.0eHpCN6UC9@wuerfel>
References: <1410184472-17630-1-git-send-email-Liviu.Dudau@arm.com>
 <540E960D.7080408@huawei.com>
 <20140909084621.GS27864@e106497-lin.cambridge.arm.com>
 <3780051.0eHpCN6UC9@wuerfel>
Message-ID: <CAErSpo5ZyanUNiVnkt0q1m-HhMpTN+ZUVL59o70THyL_hKZAdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 9, 2014 at 3:16 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 09 September 2014 09:46:21 Liviu Dudau wrote:
>> On Tue, Sep 09, 2014 at 06:54:21AM +0100, Yijing Wang wrote:
>> > PCI domain(or named segment) is provided by firmware, in ACPI system, we evaluated it
>> > by method "_SEG". in IA64 with ACPI, PCI hostbridge driver retrieves the domain from ACPI,
>> > if it's absent, the default domain is zero. So I wonder why in DTS, if it's absent, we get
>> > a auto increment domain value.
>>
>> Because you can have more than one hostbridge (rare, but not impossible) and unless you
>> want to join the two segments, you might want to give it a different domain.
>
> I think you misunderstood the question. The difference is that in ACPI you
> are required to specify the domain, while in DT it is optional with your
> implementation.

_SEG is actually optional, but the spec (ACPI r5.0, sec 6.5.6) says to
assume domain 0 if _SEG is absent.

Yijing mentioned ia64, which is relevant because PCI config accesses
on ia64 are done via a firmware (SAL) interface, and the domain is
part of that interface, so the kernel is actually required to supply
the correct domain number (0 or _SEG value) for each host bridge.

Bjorn
