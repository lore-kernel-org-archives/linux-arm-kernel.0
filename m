From: ykk@rock-chips.com (Yakir)
Date: Wed, 01 Apr 2015 09:54:47 +0800
Subject: [PATCH RFC 01/11] drm: bridge/dw_hdmi: clean up
 hdmi_set_clk_regenerator()
In-Reply-To: <20150331103519.GR24899@n2100.arm.linux.org.uk>
References: <20150330193911.GM24899@n2100.arm.linux.org.uk>
 <E1YcfXV-0002uL-9O@rmk-PC.arm.linux.org.uk> <551A44F9.80108@rock-chips.com>
 <20150331103519.GR24899@n2100.arm.linux.org.uk>
Message-ID: <551B4FE7.3040804@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rusell,

? 2015/3/31 18:35, Russell King - ARM Linux ??:
> On Tue, Mar 31, 2015 at 02:55:53AM -0400, Yang Kuankuan wrote:
>> Hi Russell,
>>
>> I'm okay with this change, and also I am preparing that collect N/CTS
>> setting to an array, like this :
>>
>>      struct n_cts {
>>          unsigned int cts;
>>          unsigned int n;
>>      };
>>
>>      struct tmds_n_cts {
>>          unsigned long tmds;
>>          /* 1 entry each for 32KHz, 44.1KHz, and 48KHz */
>>          struct n_cts n_cts[3];
>>      };
>>
>>      static const struct tmds_n_cts n_cts_table[] = {
>>          { 25175000, {{ 28125,  4576}, { 31250,  7007}, { 25175, 6144} } },
>>      }
> I think this is something which should be a common helper rather than
> being specific to the driver.  I believe these are the standard values
> for coherent audio/video clocks which can be found in the HDMI
> specifications.  Such a helper should document that it is only for
> use when the audio and video clocks are coherent.

Yep, it will be logical to add the n/cts calcu to a common helper. And 
actually
the HDMI specifications have give the Revommended N and Expected CTS 
values for
several standard TMDS clock rates(25.2/1.001 ...).

>
> (The HDMI spec gives alternative N values for use with auto-CTS value
> generation for non-coherent clocks.)
>
> I'd also prefer the lookup to use the same units as the drm_display_mode
> video clock specification, which is kHz, so we can eventually kill the
> needless *1000 in dw_hdmi.
>
> One of the issues with using a common helper is that the common helper
> would include the 1.001 clocks, which are allegedly unsupported by the
> FSL iMX6 implementation, and, if proven that they don't work, we would
> need some way to disable audio for those devices.

Okay, but rockchip platform can handle the 1.001 clocks, so maybe we can 
call
some valid function from dw_hdmi-imx & dw_hdmi-rockchip to mark the 
effective
clock that platform support ?

>> But I am confused by the "hdmi->ratio", this variable was modify to
>> 100 in bind funciton, then nowhere would change it again. In this
>> case "hdmi->ratio" seems an unused variable, can we remove it ?
> I guess the FSL sources should be checked to find out what the intended
> use for that was, and we then need to decide whether to keep it (and
> implement it) or remove it.
Need FSL ack...

Best regards.
Yakir Yang
