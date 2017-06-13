From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 13 Jun 2017 18:05:57 +0800
Subject: [PATCH v2 03/11] drm: sun4i: ignore swapped mixer<->tcon
 connection for DE2
In-Reply-To: <20170613094347.nlvxcaopd5qyq3tb@flea.lan>
References: <20170604160149.30230-1-icenowy@aosc.io>
 <20170604160149.30230-4-icenowy@aosc.io>
 <20170607093512.rfvpefmyskgjw3ik@flea.lan>
 <01A7F22E-C4FF-4B4B-A9BC-FF0C96B996B9@aosc.io>
 <20170607143827.4ng5gedvzn3f5pyx@flea.lan>
 <66881eac1dd06d918692482bdb1ea9e6@aosc.io>
 <20170609144649.67i3zscq26jt5hhe@flea.home>
 <03e5cb4ada3e19ed3476e1d562450f6f@aosc.io>
 <20170613094347.nlvxcaopd5qyq3tb@flea.lan>
Message-ID: <CAGb2v66NPY0hDL+sTmyfAQq+cpR6rGtVriXTyDG2CRHjoMMEDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 13, 2017 at 5:43 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sat, Jun 10, 2017 at 10:57:28PM +0800, icenowy at aosc.io wrote:
>> ? 2017-06-09 22:46?Maxime Ripard ???
>> > On Thu, Jun 08, 2017 at 01:01:53PM +0800, icenowy at aosc.io wrote:
>> > > ? 2017-06-07 22:38?Maxime Ripard ???
>> > > > On Wed, Jun 07, 2017 at 06:01:02PM +0800, Icenowy Zheng wrote:
>> > > > > >I have no idea what this is supposed to be doing either.
>> > > > > >
>> > > > > >I might be wrong, but I really feel like there's a big mismatch
>> > > > > >between your commit log, and what you actually implement.
>> > > > > >
>> > > > > >In your commit log, you should state:
>> > > > > >
>> > > > > >A) What is the current behaviour
>> > > > > >B) Why that is a problem
>> > > > > >C) How do you address it
>> > > > > >
>> > > > > >And you don't.
>> > > > > >
>> > > > > >However, after discussing it with Chen-Yu, it seems like you're trying
>> > > > > >to have all the mixers probed before the TCONs. If that is so, there's
>> > > > > >nothing specific to the H3 here, and we also have the same issue on
>> > > > > >dual-pipeline DE1 (A10, A20, A31). Chen-Yu worked on that a bit, but
>> > > > > >the easiest solution would be to move from a DFS algorithm to walk
>> > > > > >down the graph to a BFS one.
>> > > > > >
>> > > > > >That way, we would add all mixers first, then the TCONs, then the
>> > > > > >encoders, and the component framework will probe them in order.
>> > > > >
>> > > > > No. I said that they're swappable, however, I don't want to
>> > > > > implement the swap now, but hardcode 0-0 1-1 connection.
>> > > >
>> > > > We're on the same page, it's definitely not what I was mentionning
>> > > > here. This would require a significant rework, and the usecase is
>> > > > still unclear for now.
>> > > >
>> > > > > However, as you and Chen-Yu said, device tree should reflect the
>> > > > > real hardware, there will be bonus endpoints for the swapped
>> > > > > connection.
>> > > >
>> > > > If by bonus you mean connections from mixer 0 to tcon 1 and mixer 1 to
>> > > > tcon 0, then yes, we're going to need it.
>> > > >
>> > > > > What I want to do is to ignore the bonus connection, in order to
>> > > > > prevent them from confusing the code.
>> > > > >
>> > > > > If you just change the bind sequence, I think it cannot be
>> > > > > prevented that wrong connections will be bound.
>> > > >
>> > > > This is where I don't follow you anymore. The component framework
>> > > > doesn't list connections but devices. The swapped connections do not
>> > > > matter here, we have the same set of devices: mixer0, mixer1, tcon0
>> > > > and tcon1.
>> > > >
>> > > > The thing that does change with your patch is that before, the binding
>> > > > sequence would have been mixer0, tcon0, tcon1, mixer1. With your
>> > > > patch, it's mixer0, tcon0, mixer1, tcon1.
>> > > >
>> > > > So, again, stating what issue you were seeing before making this patch
>> > > > would be very helpful to see what you're trying to do / fix.
>> > >
>> > > So maybe I can drop the forward search (searching output) code, and
>> > > keep
>> > > only the backward search (search input) code in TCON?
>> > >
>> > > Forward search code is only used when binding, but backward search
>> > > is used
>> > > for TCON to find connected mixer.
>> >
>> > It is hard to talk about a solution, when it's not clear what the
>> > issue is.
>> >
>> > So please state
>> > > > > >A) What is the current behaviour
>> > > > > >B) Why that is a problem
>> > > > > >C) How do you address it
>> >
>> > We'll talk about a solution once this is done.
>>
>> (All those things are based on the assumption that mixer0, mixer1, tcon0
>> and tcon1 are all enabled in DT. If one group of mixer-tcon pair is fully
>> disabled in DT it will behave properly.)
>>
>> For the backward search:
>>
>> A) The current behaviour is to take the first engine found, which will be
>> wrong in the situation of tcon1 if mixer0 and mixer1 are both enabled:
>> mixer0 is taken for tcon1 instead of mixer1.
>>
>> B) It takes mixer0 as it matches the first endpoint of tcon0's input.
>>
>> C) It's a logic failure in the backward search, as it only considered
>> the DE1 situation, in which TCONs will only have one engine as input.

Then you should fix it so it works with DE2. For DE2 it would be something
like this:

Mixer probe
-----------
You have two choices on how to get its ID: a) Look downstream to TCONs,
and get the reg value from the remote endpoint, or b) get the display-engine
node, and check the index of the phandle that points to itself (the mixer).
A is easier, and it is why I asked you to follow the connection ID rule in
the device tree binding.

TCON probe
----------
Similar to A) for the mixers, look upstream and get the reg value from the
remote endpoint.

Afterwards you would have correct IDs on both sides, then it's just a matter
of going through the list of mixers and TCONs and pairing them up.


Mixer0  0 ---- 0  TCON0
        1      1 <- This would be the remote endpoint reg value for mixer1.
         \    /
          \  /
           \/
           /\
          /  \
         /    \
        0      0 <- This would be the remote endpoint reg value for mixer0.
Mixer1  1 ---- 1  TCON1

Hope this makes things clearer.

>
> That's not true. DE1's can output to several TCONs (or rather, TCONs
> can select multiple engines as their input). The A31 for example is in
> this case.

Actually that's not true. The TCON is bound to the backend. I don't see
any controls for muxing that. So the TCON-backend search routine is very
simple for DE1. The frontends are free to feed either backend though.

> I think what Chen-Yu did so far is that he only enables one engine and
> TCON for now. That will leave us some time to rework and improve
> things gradually. It would probably be easier (and faster) for you too.

My code deals with muxes between the TCON and the downstream encoders (HDMI/TV).

You need something similar to deal with the mux between the mixers and TCONs.
My code doesn't fit DE2, because the case hadn't been added yet.

>> For the bind process:
>>
>> A) The current behaviour is to try to bind all output endpoints of the
>> engine, during binding all outputs of mixer0, these will happen:
>>   1. tcon1 is bound with mixer0 as its engine if backward searching
>>   is not fixed.
>>   2. tcon1 fails to be bound as its engine is not yet bound when
>>   backward searching works properly, then sun4i_drv will refuse
>>   to continue as a component is not properly bound.
>
> So this is the ordering issue I was mentionning earlier. The way to
> fix this is to use BFS instead of DFS when building the component
> list.
>
>> B) The binding process in sun4i_drv will bind a component that is not
>> really an working output of the forward component, but only exists in
>> the endpoint list as a theortically possible output (in fact not an
>> real output).
>
> I'm not sure what you mean by that. Isn't the tcon1 a real output for
> mixer0?
>
>> C) I tested with this patch's sun4i_drv_node_is_swappable_de2_mixer
>> function masked (always return false), and then the multiple
>> mixer+tcon situations don't work properly.
>>
>> P.S. I think the BFS solution is really a dirty hack -- although we
>> bind components, not connections, we should decide the next component
>> to bind according to the connections -- not really connected
>> components shouldn't be bound.
>
> This isn't really about whether you follow connections or not, in both
> cases you do. It's how you follow those connections that matters, and
> it does make sense to follow them stage by stage in our
> pipeline. ie. something that would bind all the engines, then all the
> TCONs, then all the encoders.
>
> All of them would have connections between them.
>
>> For example, if we enabled mixer0, tcon0 and tcon1, tcon1 shouldn't
>> be bound at all. However in BFS situation tcon1 will also be bound
>> and then fail to be bound if the backward engine searching is fixed.
>
> Short term view: we shouldn't be in that case in the first place.
> Long term view: there's no reason it shouldn't work.

Maybe I missed something? TCONs and everything before them should always
be enabled. There's no reason not to. This is especially true for TCON0
which holds the mux register on some SoCs.

About Maxime's long term view: there's no reason we can't just silently
ignore a component if its supposed companion is missing, like a TCON
missing its backend, or the other way around. The current code already
covers the latter case: since the CRTC (and by extension, all DRM/KMS
functionality related to that pipeline) is created in the TCON bind
function, if the TCON is not enabled, the backend just idles.

ChenYu
