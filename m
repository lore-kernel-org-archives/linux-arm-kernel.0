From: robherring2@gmail.com (Rob Herring)
Date: Tue, 9 Sep 2014 21:44:56 -0500
Subject: [PATCH v10 07/10] OF: Introduce helper function for getting PCI
 domain_nr
In-Reply-To: <20140909154123.GA12906@obsidianresearch.com>
References: <1410184472-17630-1-git-send-email-Liviu.Dudau@arm.com>
 <1410184472-17630-8-git-send-email-Liviu.Dudau@arm.com>
 <CAL_JsqJi8k1Goc3UmXhuxf9v7=4gJrYG_Di7v574PxS8TsJaXw@mail.gmail.com>
 <20140908145459.GO27864@e106497-lin.cambridge.arm.com>
 <CAL_JsqJdGKDVwJOpPp19OkVPGzR7Zqv3nh+ONHHaYnPLYTYoYg@mail.gmail.com>
 <20140908155931.GP27864@e106497-lin.cambridge.arm.com>
 <540E960D.7080408@huawei.com>
 <20140909084621.GS27864@e106497-lin.cambridge.arm.com>
 <540EC8CB.7010106@huawei.com>
 <CAErSpo4cAfom2=07NYDRfTCdHO22M0v+ueiaZuG6v2Xd18wEnQ@mail.gmail.com>
 <20140909154123.GA12906@obsidianresearch.com>
Message-ID: <CAL_JsqJMRqbwNkB2K6Mg2DU9mSHwAObtD7LLG2_n=4jGDAFhyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 9, 2014 at 10:41 AM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Tue, Sep 09, 2014 at 08:26:19AM -0600, Bjorn Helgaas wrote:
>
>> So as long as the DT tells you the ECAM information for each host
>> bridge, that should be sufficient.  The domain number is then just a
>> Linux convenience and is not tied to the platform as it is on ia64.
>
> I think this is right for DT systems - the domain is purely internal
> to the kernel and userspace, it is used to locate the proper host
> bridge driver instance, which contains the proper config accessor (and
> register bases, etc).
>
> AFAIK the main reason to have a DT alias to learn the domain number is
> to make it stable so things like udev/etc can reliably match on the
> PCI location.

For what purpose?

> This is similar to i2c, etc that use the alias scheme, so IMHO
> whatever they do to assign ID's to drivers should be copied for domain
> numbers.

IMO they should not. We really want to move away from aliases, not
expand their use. They are used for serial because there was no good
way to not break things like "console=ttyS0". I2C I think was more
internal, but may have been for i2c-dev. What are we going to break if
we don't have consistent domain numbering? If the domain goes into the
DT, I'd rather see it as part of the PCI root node. But I'm not
convinced it is needed.

It doesn't really sound like we have any actual need to solve this for
DT ATM. It's not clear to me if all buses should be domain 0 or a
simple incrementing index for each bus in absence of any firmware set
value.

Rob
