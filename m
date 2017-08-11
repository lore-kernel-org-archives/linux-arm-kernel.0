From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Fri, 11 Aug 2017 15:26:10 -0700
Subject: [PATCH v2 2/3] usb: chipidea: Hook into mux framework to toggle
 usb switch
In-Reply-To: <c5c411fe-2f5a-88cc-73e8-28ab61f5de04@axentia.se>
References: <20170714214005.14967-1-stephen.boyd@linaro.org>
 <20170714214005.14967-3-stephen.boyd@linaro.org>
 <7080030c-c9c2-657d-aad4-aef636438cb1@axentia.se>
 <150215709134.18242.599725161375995991@sboyd-linaro>
 <c5c411fe-2f5a-88cc-73e8-28ab61f5de04@axentia.se>
Message-ID: <150249037091.15411.10074988823155268663@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter Rosin (2017-08-08 05:46:30)
> On 2017-08-08 03:51, Stephen Boyd wrote:
> 
> >                      It looked like we paired the start/stop ops with
> > each other so that the mux is properly managed across these ops.
> 
> Yes, it *looks* ok...
> 
> >                                                                  My
> > testing hasn't shown a problem, but maybe there's some corner case
> > you're thinking of? I'll double check the code.
> 
> ...but since I do not know the usb code, I can't tell. What I worry about
> is the usb core calling udc_id_switch_for_host or udc_id_switch_for_device
> more than once without any call to the other in between. Maybe that is a
> guarantee that the usb core makes? Or maybe it isn't? If e.g. there is a
> third mode (or if one is added in the future), then the calls to
> mux_control_select and mux_control_deselect would not be paired correctly.
> Ok, sure, a third mode probably doesn't exist and will probably not be
> added, but but but...
> 
> Also, what happens if udc_id_switch_for_device fails? Is it certain that
> it will be called again before udc_id_switch_for_host is called, or is
> the failure simply logged? If the latter, you might have a call to
> mux_control_deselect without a preceding (and successful) call to
> mux_control_select. That's fatal.

The only thing that could fail right now is the mux selection, so we
wouldn't get into some sort of situation where that's locked in and
unchangeable. We do rollback the role if it fails to switch, so we also
wouldn't go into a half-way state of being in one role but not actually
switching all the way over to it.

> 
> I have similar worries for host_start/host_stop, but for that case
> host_stop is not allowed to fail, and it seems like a safe bet that
> host_stop will only be called if host_start succeeds. So, I'm not as
> worried there.
> 
> In other words, the question is if the usb core is designed to allow
> this kind of "raw" resource administration in udc_id_switch_for_host and
> udc_id_switch_for_device, or if you need to keep a local record of the
> state so that you do not do double resource acquisition or attempt to
> free resources you don't have?
> 
> I think I would feel better if the muxing for the device mode could
> be done in a start/stop pair of function just like the host mode is
> doing. Again, I don't know the usb code and don't know if such hooks
> exist or not?
> 

The host_start/host_stop functions are assigned to the same struct
ci_role_driver ops that udc_idc_switch_for_{device,host} are for the
gadget role. Really, these things are called from the same place by the
chipidea driver so not much is different between the two files I modify
to make the mux calls. Furthermore, we don't want to do this if we have
HNP or "true" OTG support so I've put it behind the ci_otg_is_fsm_mode()
check to make sure we don't do any muxing stuff based on fsm state
changes. It doesn't really make any sense here anyway because this
device I have doesn't support OTG, just role switching.
