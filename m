From: rabin@rab.in (Rabin Vincent)
Date: Mon, 15 Apr 2013 13:36:00 +0200
Subject: [PATCH 3/8] dmaengine: ste_dma40: Actually write the runtime
 configuration to registers
In-Reply-To: <20130415110601.GE6512@gmail.com>
References: <1365532783-27425-1-git-send-email-lee.jones@linaro.org>
 <1365532783-27425-3-git-send-email-lee.jones@linaro.org>
 <CAH+eYFB_fYmCjvh5PXKRhd-FnaWfeu+LtH+q3VywhCk-PYhHVQ@mail.gmail.com>
 <20130415110601.GE6512@gmail.com>
Message-ID: <CAH+eYFB2+oMPXsnzQVVrEK8CjKGVYFa_n4Wxr=CpdtJwFfOGYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/4/15 Lee Jones <lee.jones@linaro.org>:
> On Fri, 12 Apr 2013, Rabin Vincent wrote:
>> 2013/4/9 Lee Jones <lee.jones@linaro.org>:
>> > Someone has spent a fair amount of effort writing a runtime configuration
>> > changing algorithm for DMA clients. However, the config appears to never
>> > actually make it to hardware. In order for the configuration to take hold
>> > we need to issue a d40_config_write(), as this is the routine which writes
>> > it into the hardware's registers.
>>
>> No, it's not.  This function is only for initial configuration which
>> should only be written when the channel is allocated.  In fact, by
>> calling it here in runtime_config, you are introducing a serious bug:
>> other logical channels on the same physical channel will stop because of
>> the SSLNK/SDLNK of the physical channel being zeroed.
>>
>> The runtime config already makes it the hardware in the existing code,
>> via d40_*_cfg().
>
> Sorry Rabin, but the only place I can see the config being written is
> in d40_config_write().
>
> Can you paste the line of code in d40_*_cfg() which actually writes
> the config to hardware please? I don't see it.

It's not that simple.  There are some pointers passed to d40_*_cfg() and
that function writes the configuration to the variables those pointers
point to (d40c->log_def.lcsp1, d40c->src_def_cfg, etc.).  Please read
the code to see how those variables end up being used later when the
LLIs are prepared for the HW.
