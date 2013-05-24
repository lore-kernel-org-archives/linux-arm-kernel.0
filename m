From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 24 May 2013 15:15:41 -0700
Subject: [PATCH] ARM: DTS: OMAP4: Panda/SDP: twl6030: fix mux for IRQ pin
 and msecure line
In-Reply-To: <87a9nkf3mu.fsf@linaro.org> (Kevin Hilman's message of "Fri, 24
 May 2013 14:51:21 -0700")
References: <1369423702-31501-1-git-send-email-khilman@linaro.org>
 <20130524200954.GA2344@kahuna> <20130524203231.GA2555@kahuna>
 <87obc0f54r.fsf@linaro.org>
 <CAGo_u6oz1v1J-6z5W-X7CsOmi+7SAMicz1LZTv0sVXhej1DJ2Q@mail.gmail.com>
 <87a9nkf3mu.fsf@linaro.org>
Message-ID: <87ppwgdnxu.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@linaro.org> writes:

> Nishanth Menon <nm@ti.com> writes:

[...]

>> Actually 2 things:
>>
>> a) patch seems to do the wrong thing for 4460 - 0x18 offset should
>> have been used instead of 0x14 which is correct for 4430?
>
> I see, thanks.  I'll double check the TRMs.
>
>> b) yes, I understand,  the current settings we did worked, but the
>> mode(0) we are setting to is real weird - we are setting it up for
>> clk0 out - I cant even think why it is even working in the first place
>> :( - is it because we are pumping out sysclkout and as a result we are
>> lucky that msecure is being sampled at the right point by twl6030
>> allowing rtc access? either way, IMHO, the configuration is wrong.
>
> Ah, yes.  Mode zero is definitely wrong.   When I did the original patch
> for legacy mode, I just duplicated the settings u-boot was using.  Guess
> it's a fluke that it works.

Actually, for legacy mode, it's set correctly in mode 2.  This line:

	omap_mux_init_signal("fref_clk0_out.sys_drm_msecure", OMAP_PIN_OUTPUT);

does the right thing based on the signal name.    But for DT boot, I
defintely screwed it up by setting it to mode (and putting it in the
wrong padconf section.)

Also, are you *really* sure about the offset difference between 4430 and
4460 here?  I don't have access to NDA docs anymore, so I cannot double
check this.

What I do know is that the legacy code is using 0x54 for both, and if I
simply comment out that 'sys_drm_msecure' line above, RTC wake stops
working (legacy boot) on both 4430 and 4460, so that seems like pretty
stront evidence that it's the same offset on both.

Kevin
