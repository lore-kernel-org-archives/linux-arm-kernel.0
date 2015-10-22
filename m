From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 22 Oct 2015 15:59:14 -0700
Subject: [PATCH 1/2] ARM: ux500: add an SMP enablement type and move cpu
 nodes
In-Reply-To: <CAMAWPa_nVyyhXfBm3HvPyVGpodJe_dfM0kX0kO+rPtO9mfkG=w@mail.gmail.com>
References: <1438586801-30115-1-git-send-email-linus.walleij@linaro.org>
 <CAMAWPa_nVyyhXfBm3HvPyVGpodJe_dfM0kX0kO+rPtO9mfkG=w@mail.gmail.com>
Message-ID: <CAMAWPa_iBuJtMs72RcQzBPf73csiCuw+45_BrVHFC4qiZyJU7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 9:52 PM, Kevin Hilman <khilman@kernel.org> wrote:
> Hi Linus,
>
> On Mon, Aug 3, 2015 at 12:26 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> The "cpus" node cannot be inside the "soc" node, while this
>> works for the CoreSight blocks, the early boot code will look
>> for "cpus" directly under the root node, so this is a hard
>> convention. So move the CPU nodes.
>>
>> Augment the "reg" property to match what is actually in the
>> hardware: 0x300 and 0x301 respectively.
>>
>> Then add an SMP enablement type to be used by the SMP init
>> code, "ste,dbx500-smp".
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Hi ARM SoC people: please apply this as a fix for v4.2
>> as it is prerequisite for 2/2 which is a more proper fix
>> for the secondary CPU boot regression addressed by the
>> fixed remappings patch.
>
> kernelci.org has had the ste-snowall failing in v4.2 stable[1] for
> awhile, so I finally bisected[2] it down to this patch, which is in
> mainline in the form of commit bf64dd262eaa (ARM: ux500: add an SMP
> enablement type and move cpu nodes).  I confirmed that reverting that
> commit on top of v4.2 gets the snowball booting again.

OK, I figured this one out.  The patch above that bisect found was
patch 1 of a 2-patch series, and the 2nd patch didn't make it into
v4.2 for various reasons.

I've now remedied that and verified that adding the 2nd patch:
mainline commit c00def71efd9 (ARM: ux500: simplify secondary CPU boot)
on top of stable/v4.2.y gets the snowball booting again.

I've submitted that patch for inclusion into stable/linux-4.2.y.

Kevin
