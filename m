From: icenowy@aosc.io (icenowy at aosc.io)
Date: Sat, 10 Jun 2017 23:16:35 +0800
Subject: [PATCH v2 03/11] drm: sun4i: ignore swapped mixer<->tcon
 connection for DE2
In-Reply-To: <03e5cb4ada3e19ed3476e1d562450f6f@aosc.io>
References: <20170604160149.30230-1-icenowy@aosc.io>
 <20170604160149.30230-4-icenowy@aosc.io>
 <20170607093512.rfvpefmyskgjw3ik@flea.lan>
 <01A7F22E-C4FF-4B4B-A9BC-FF0C96B996B9@aosc.io>
 <20170607143827.4ng5gedvzn3f5pyx@flea.lan>
 <66881eac1dd06d918692482bdb1ea9e6@aosc.io>
 <20170609144649.67i3zscq26jt5hhe@flea.home>
 <03e5cb4ada3e19ed3476e1d562450f6f@aosc.io>
Message-ID: <0b7d3cc334929ab2464477bbccc37e31@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-06-10 22:57?icenowy at aosc.io ???
> ? 2017-06-09 22:46?Maxime Ripard ???
>> On Thu, Jun 08, 2017 at 01:01:53PM +0800, icenowy at aosc.io wrote:
>>> ? 2017-06-07 22:38?Maxime Ripard ???
>>> > On Wed, Jun 07, 2017 at 06:01:02PM +0800, Icenowy Zheng wrote:
>>> > > >I have no idea what this is supposed to be doing either.
>>> > > >
>>> > > >I might be wrong, but I really feel like there's a big mismatch
>>> > > >between your commit log, and what you actually implement.
>>> > > >
>>> > > >In your commit log, you should state:
>>> > > >
>>> > > >A) What is the current behaviour
>>> > > >B) Why that is a problem
>>> > > >C) How do you address it
>>> > > >
>>> > > >And you don't.
>>> > > >
>>> > > >However, after discussing it with Chen-Yu, it seems like you're trying
>>> > > >to have all the mixers probed before the TCONs. If that is so, there's
>>> > > >nothing specific to the H3 here, and we also have the same issue on
>>> > > >dual-pipeline DE1 (A10, A20, A31). Chen-Yu worked on that a bit, but
>>> > > >the easiest solution would be to move from a DFS algorithm to walk
>>> > > >down the graph to a BFS one.
>>> > > >
>>> > > >That way, we would add all mixers first, then the TCONs, then the
>>> > > >encoders, and the component framework will probe them in order.
>>> > >
>>> > > No. I said that they're swappable, however, I don't want to
>>> > > implement the swap now, but hardcode 0-0 1-1 connection.
>>> >
>>> > We're on the same page, it's definitely not what I was mentionning
>>> > here. This would require a significant rework, and the usecase is
>>> > still unclear for now.
>>> >
>>> > > However, as you and Chen-Yu said, device tree should reflect the
>>> > > real hardware, there will be bonus endpoints for the swapped
>>> > > connection.
>>> >
>>> > If by bonus you mean connections from mixer 0 to tcon 1 and mixer 1 to
>>> > tcon 0, then yes, we're going to need it.
>>> >
>>> > > What I want to do is to ignore the bonus connection, in order to
>>> > > prevent them from confusing the code.
>>> > >
>>> > > If you just change the bind sequence, I think it cannot be
>>> > > prevented that wrong connections will be bound.
>>> >
>>> > This is where I don't follow you anymore. The component framework
>>> > doesn't list connections but devices. The swapped connections do not
>>> > matter here, we have the same set of devices: mixer0, mixer1, tcon0
>>> > and tcon1.
>>> >
>>> > The thing that does change with your patch is that before, the binding
>>> > sequence would have been mixer0, tcon0, tcon1, mixer1. With your
>>> > patch, it's mixer0, tcon0, mixer1, tcon1.
>>> >
>>> > So, again, stating what issue you were seeing before making this patch
>>> > would be very helpful to see what you're trying to do / fix.
>>> 
>>> So maybe I can drop the forward search (searching output) code, and 
>>> keep
>>> only the backward search (search input) code in TCON?
>>> 
>>> Forward search code is only used when binding, but backward search is 
>>> used
>>> for TCON to find connected mixer.
>> 
>> It is hard to talk about a solution, when it's not clear what the
>> issue is.
>> 
>> So please state
>>> > > >A) What is the current behaviour
>>> > > >B) Why that is a problem
>>> > > >C) How do you address it
>> 
>> We'll talk about a solution once this is done.
> 
> (All those things are based on the assumption that mixer0, mixer1, 
> tcon0
> and tcon1 are all enabled in DT. If one group of mixer-tcon pair is 
> fully
> disabled in DT it will behave properly.)

So there's a temporary workaround -- only enable one pipeline and 
disable
the unused mixer and tcon totally.

It's shown to work with this commit reverted in my local TVE branch. 
(The
swappable_input value is also deleted from H3 TCON's quirks)

> 
> For the backward search:
> 
> A) The current behaviour is to take the first engine found, which will 
> be
> wrong in the situation of tcon1 if mixer0 and mixer1 are both enabled:
> mixer0 is taken for tcon1 instead of mixer1.
> 
> B) It takes mixer0 as it matches the first endpoint of tcon0's input.
> 
> C) It's a logic failure in the backward search, as it only considered
> the DE1 situation, in which TCONs will only have one engine as input.
> 
> For the bind process:
> 
> A) The current behaviour is to try to bind all output endpoints of the
> engine, during binding all outputs of mixer0, these will happen:
>   1. tcon1 is bound with mixer0 as its engine if backward searching
>   is not fixed.
>   2. tcon1 fails to be bound as its engine is not yet bound when
>   backward searching works properly, then sun4i_drv will refuse
>   to continue as a component is not properly bound.
> B) The binding process in sun4i_drv will bind a component that is not
> really an working output of the forward component, but only exists in
> the endpoint list as a theortically possible output (in fact not an
> real output).
> C) I tested with this patch's sun4i_drv_node_is_swappable_de2_mixer
> function masked (always return false), and then the multiple
> mixer+tcon situations don't work properly.
> 
> P.S. I think the BFS solution is really a dirty hack -- although we
> bind components, not connections, we should decide the next component
> to bind according to the connections -- not really connected
> components shouldn't be bound.
> 
> For example, if we enabled mixer0, tcon0 and tcon1, tcon1 shouldn't
> be bound at all. However in BFS situation tcon1 will also be bound
> and then fail to be bound if the backward engine searching is fixed.
> 
>> 
>> Maxime
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
