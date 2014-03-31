From: s-anna@ti.com (Suman Anna)
Date: Mon, 31 Mar 2014 17:45:15 -0500
Subject: [PATCHv4 0/7] omap hwspinlock dt support
In-Reply-To: <CAK=WgbZ1M0JZE2BH0ukNo33hBuffTGbd3-DD0WCiwZ-akgvQ-Q@mail.gmail.com>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com>
 <52F9282B.5000702@ti.com> <530B8C00.8020001@ti.com>
 <CAK=WgbZp_RQPCeZJyMRkNTQxaJsnGZ3DnjhSkYYR_-PAE_Kp4g@mail.gmail.com>
 <53239789.40600@ti.com>
 <CAK=WgbZCzA7JovSxnysHCQRZZWc3Z2j3AS8ekpM9fOZ160rmCA@mail.gmail.com>
 <532748B7.1080606@ti.com>
 <CAK=WgbYjtw+cxy5wX6pjK=Rpj6wOk6Cu+GrPuFN+sqtgDAY=_Q@mail.gmail.com>
 <53278950.5030905@ti.com>
 <CAK=WgbZ1M0JZE2BH0ukNo33hBuffTGbd3-DD0WCiwZ-akgvQ-Q@mail.gmail.com>
Message-ID: <5339EFFB.30304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2014 08:35 AM, Ohad Ben-Cohen wrote:
> Hi Suman,
> 
> On Tue, Mar 18, 2014 at 1:46 AM, Suman Anna <s-anna@ti.com> wrote:
>> So far, we have not come across multiple controllers. I see your point,
>> and I think this also depends on the semantics of how you exchange the
>> lock id number. The agreement at the moment is on base_ids across
>> multiple SoC components. If the semantics involve exchanging the
>> controller instance, for example, then we might get away with it. But
>> that probably involves adding additional helpers to retrieve controller
>> instance in addition to lock number, or some other similar functions.
> 
> Yes, this could be done too, but I agree it is less simple with no real win.
> 
>> Sorry, I should have rephrased it better - by order, I meant the
>> inherent order between board early code and other drivers. With DT, we
>> cannot guarantee that right, as specific locks are requested from drivers.
> 
> Yeah.
> 
>> Understood. And we may have to assign the client association with a lock
>> as well. These are core changes that were actually not needed in the
>> non-DT case due to the inherent order as stated above. So, are you
>> suggesting that we add one more property to the controller node to mark
>> which are reserved, or rely on constructing this through DT tree parsing?
> 
> I guess this is a question to the DT folks; both approaches work from
> hwspinlock perspective.
> 
> In the past Arnd Benoit and myself were happy with adding one more
> property to the controller node, but this might be somewhat error
> prone as it leaves room for mistakes - developers can add hwlock
> phandles and forget to update the reserved property in the controller
> node.

Ohad,
I agree that this is the most simplest form (either a reserved number
starting from base, or a reserved range - I prefer the first). The
developer errors can be restricted by having the
of_hwspin_lock_request_specific() return an error if anything outside
this reserved range is requested.

Mark, Kumar,
Any recommendations/objections on this problem/approach?

I also have to bring back the hwlock-base-id property (dropped in v3)
for registration purposes, so that the registration does not change
based on the probe order of the multiple controller nodes.

regards
Suman
