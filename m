From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 12 Nov 2013 09:40:53 -0800
Subject: [RFC PATCHv2 3/4] of: provide a binding for fixed link PHYs
In-Reply-To: <20131112162914.GE4237@e106331-lin.cambridge.arm.com>
References: <1378480701-12908-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130918042923.5D845C42CF7@trevor.secretlab.ca>
 <20130918181112.56c10dde@skate>
 <1811694.J4B6oUpKxP@lenovo> <20131112123746.EAEF0C42283@trevor.secretlab.ca>
 <20131112162914.GE4237@e106331-lin.cambridge.arm.com>
Message-ID: <CAGVrzcaSoJ8XXYj=D8R4Vw+yaRqfd-wU4EgigjefRxbg=pufhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/11/12 Mark Rutland <mark.rutland@arm.com>:
> Hi Florian, Grant,
>
> On Tue, Nov 12, 2013 at 12:37:46PM +0000, Grant Likely wrote:
>> On Fri, 25 Oct 2013 05:40:57 +0100, Florian Fainelli <florian@openwrt.org> wrote:
>> > Le mercredi 18 septembre 2013, 18:11:12 Thomas Petazzoni a ??crit :
>> > > Dear Grant Likely,
>> > >
>> > > On Tue, 17 Sep 2013 23:29:23 -0500, Grant Likely wrote:
>> > > > I understand what you're trying to do here, but it causes a troublesome
>> > > > leakage of implementation detail into the binding, making the whole
>> > > > thing look very odd. This binding tries to make a fixed link look
>> > > > exactly like a real PHY even to the point of including a phandle to the
>> > > > phy. But having a phandle to a node which is *always* a direct child of
>> > > > the MAC node is redundant and a rather looney. Yes, doing it that way
>> > > > makes it easy for of_phy_find_device() to be transparent for fixed link,
>> > > > but that should *not* drive bindings, especially when that makes the
>> > > > binding really rather weird.
>> > > >
>> > > > Second, this new binding doesn't provide anything over and above the
>> > > > existing fixed-link binding. It may not be pretty, but it is
>> > > > estabilshed.
>> > >
>> > > Have you followed the past discussions about this patch set? Basically
>> > > the *only* feedback I received on RFCv1 is that the fixed-link property
>> > > sucks, and everybody (including the known Device Tree binding
>> > > maintainer Mark Rutland) suggested to not use the fixed-link mechanism.
>> > > See http://article.gmane.org/gmane.linux.network/276932, where Mark
>> > > said:
>> > >
>> > > ""
>> > > I'm not sure grouping these values together is the best way of handling
>> > > this. It's rather opaque, and inflexible for future extension.
>> > > ""
>> > >
>> > > So, please DT maintainers, tell me what you want. I honestly don't care
>> > > whether fixed-link or a separate node is chosen. However, I do care
>> > > about being dragged around between two solutions just because the
>> > > former DT maintainer and the new DT maintainers do not agree.
>>
>> I've been sleepy on this issue, which limits how much I can push. I'll
>> say one more thing on the issue (below) and then leave the decision up
>> to Mark. I trust him and he knows what he is doing.
>>
>> > Since I would like to move forward so I can one day use that binding in a
>> > real-life product, I am going to go for Mark's side which happens to be how I
>> > want the binding to look like.
>> >
>> > Do we all agree that the new binding is just way better than the old one? In
>> > light of the recent unstable DT ABI discussion, we can still continue parsing
>> > the old one for the sake of compatibility.
>>
>> Regardless of what you want it to look like, does the old binding work
>> for your purposes? If yes then use it. The only valid reason for
>> creating a new binding is if the old one doesn't work for a specific
>> (not theoretical) use case.
>
> I think the issue here was that I am not versed in the history of all of
> the existing bindings. While I'm not keen on the existing fixed-link
> property and I think it should be done differently were it being created
> from scratch today, as Grant has pointed out we're already supporting it
> today, and adding a new binding is going to make the code handling it
> more complex.
>
> If fixed-link works for your use case today, then use fixed-link.

Like I said in an earlier response to Thomas yesterday, it does not
cover everything, most importantly, the existing "fixed-link" property
does not allow the representation of direct MAC to MAC connections
where you still need to specify the MII connection type for it to work
properly. This is something that can be easily provided by the new
fixed PHY binding, but less easily by the existing "fixed-link"
property. We cannot extend "fixed-link" to contain a 6th integer
because "phy-mode" or "phy-connection-type"  is a string. My options
here are pretty simple:

- use the existing "fixed-link" property even though it is not nice,
it does the job
- add a supplemental "connection-type" property and parse it in my
driver, which is where it is going to be used
- go on with the new proposed Device Tree binding

>
> If we have a valid reason to create a new binding, we should. At the
> moment I think the only egregious portion of the binding is the globally
> unique fake PHY id, and if that causes issues we should be able to
> assign IDs within Linux ignoring the values in the DT, or reorganise
> things such that the arbitrary ID doesn't matter.

I think we all agreed that the PHY ID (the term should be clarified as
it tends to either mean PHY address or PHY OUI) had to be gone, and
this is what Thomas did in this serie. Whichever binding we choose, it
should be fairly easy to keep the "PHY ID" integer in the "fixed-link"
property but make the code ignore it (with possibly a big fat warning
for a transition period).

>
> If there are configurations we need to support that the fixed-link
> property cannot encode, then I think we should go ahead with the binding
> style that you are proposing today. However, we don't need to go with it
> right away, and we can continue to support fixed-link regardless.

Well, yes, the lack of "connection-type" representation is a blocker
for some hardware configurations where two Ethernet MACs are connected
one to each other. Whether this deserves a new incarnation of the
"fixed PHY" Device Tree binding is left for discussion.

>
> I apologise for the lack of consistency here, and I'm sorry that I've
> delayed this series for so long.
-- 
Florian
