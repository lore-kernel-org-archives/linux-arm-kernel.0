From: james.hogan@imgtec.com (James Hogan)
Date: Thu, 25 Jul 2013 13:55:09 +0100
Subject: [PATCH v5 4/5] clk: add CLK_SET_RATE_NO_REPARENT flag
In-Reply-To: <51F11B46.7010900@samsung.com>
References: <1371139562-305-1-git-send-email-james.hogan@imgtec.com>
 <1371139562-305-5-git-send-email-james.hogan@imgtec.com>
 <51F11B46.7010900@samsung.com>
Message-ID: <51F1202D.9060403@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester

On 25/07/13 13:34, Sylwester Nawrocki wrote:
> On 06/13/2013 06:06 PM, James Hogan wrote:
>> Add a CLK_SET_RATE_NO_REPARENT clock flag, which will prevent muxes
>> being reparented during clk_set_rate.
>>
>> To avoid breaking existing platforms, all callers of clk_register_mux()
>> are adjusted to pass the new flag. Platform maintainers are encouraged
>> to remove the flag if they wish to allow mux reparenting on set_rate.
> [..]
>> Changes in v3:
>>
>> * rename/invert CLK_SET_RATE_REMUX to CLK_SET_RATE_NO_REPARENT and move
>>   to this new patch.
>> * patch 3: add CLK_SET_RATE_NO_REPARENT flag to all callers of
>>   clk_register_mux. If you don't mind your clocks being reparented in
>>   response to set_rate please let me know and I'll drop the relevant
>>   portion of the patch.
> 
> Why is this better to change current behaviour of the clock core
> and modify all drivers instead of having, e.g. CLK_SET_RATE_REPARENT
> set in drivers of hardware that supports clock re-parenting while
> setting clock rate ?

See this message from Mike Turquette which first suggested it:

http://marc.info/?l=linux-kernel&m=136847508109344&w=2

> Is there intention to just have the automatic clock re-parenting
> as a default feature in the common clock API ?

Yes, that would be the result (except where explicitly disallowed).
Unfortunately where such policy should ideally be defined is still up in
the air.

It's not a property of the hardware, but then it is arguably a property
of the environment the bootloader has configured (like the stuff in the
/chosen device tree node).

Presuming that the usual reason not to reparent a mux is because other
important clocks depend on it, the kernel might know enough to work out
whether it's safe (unless of course there are other cores/threads in the
SoC using the clock that Linux isn't aware of, which brings us back to
it being a bootloader environment thing).

> My apologies if this has already been answered, I haven't been
> following this thread.

No problem :)

Cheers
James
