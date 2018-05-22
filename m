From: collinsd@codeaurora.org (David Collins)
Date: Mon, 21 May 2018 17:00:49 -0700
Subject: [PATCH v3 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <CAD=FV=XfSGs14VB464cvMGDNwGS4yvSXjN8itZLffm+Sj-D=ww@mail.gmail.com>
References: <cover.1526088081.git.collinsd@codeaurora.org>
 <41d5df73ddac772551d2966e0752bb0c357b1ded.1526088081.git.collinsd@codeaurora.org>
 <CAD=FV=XegPeFR8pdZM-YiBBJjrbej=C+2biBt4zJKnE90uTYZA@mail.gmail.com>
 <869aad59-1cc5-28ef-1fb5-4ef846696c40@codeaurora.org>
 <CAD=FV=U-QOQekUHj=ck57YJbTFdFjCAWr4t2A92x+fCNf+yV9A@mail.gmail.com>
 <dc1fbe9c-8973-1c4d-0fbd-809c1ec0a6be@codeaurora.org>
 <CAD=FV=XfSGs14VB464cvMGDNwGS4yvSXjN8itZLffm+Sj-D=ww@mail.gmail.com>
Message-ID: <fb390ccb-927a-8449-05c3-8dcac964bfae@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/2018 11:01 AM, Doug Anderson wrote:
> On Fri, May 18, 2018 at 5:46 PM, David Collins <collinsd@codeaurora.org> wrote:
...
>> Something to keep in mind about the downstream rpmh-regulator driver is
>> that it caches the initial voltages specified in device tree and only
>> sends them after a consumer driver makes a regulator framework call. This
>> saves time during boot and ensures that requests are not made for
>> regulators that no Linux consumer cares about.
> 
> You're saying that in the downstream driver you'd specify
> "initial-voltage" in the device tree and:
> 
> * This voltage would be reported by any subsequent get_voltage() calls
> 
> * This voltage would _not_ be communicated to RPMh.
> 
> That seems really strange because you're essentially going to be
> returning something from get_voltage() that could be a lie.  You don't
> know if the BIOS actually set the value or not but you'll claim that
> it did.  It also doesn't seem to match what I see in the downstream
> driver.  There I see it read "qcom,init-voltage" and then do a
> "rpmh_regulator_set_reg()".  Thus my reading of the downstream driver
> is that it should do the same requests that you're doing.

In the downstream rpmh-regulator driver [1], the value specified via the
"qcom,init-voltage" DT property is only sent to RPMh at probe time if the
"qcom,send-defaults" property is also specified.  "qcom,send-defaults" is
currently specified only for PMI8998 BOB.  The rpmh_regulator_set_reg()
function only updates the cached RPMh request value to be sent in the next
request.  The rpmh_regulator_send_aggregate_requests() function must be
called to actually issue the request.

Returning the cached (but not sent) initial voltage equal to the min
constraint voltage in get_voltage() calls should not cause any problems.
This represents the highest voltage that is guaranteed to be output by the
regulator.  Consumer's should call regulator_set_voltage() to specify
their voltage needs.  If they simply call regulator_enable(), then the
cached voltage will be sent along with the enable request.


>> It is generally not safe to request all regulators to be set to the
>> minimum allowed voltage.  Special care will be needed with the upstream
>> qcom-rpmh-regulator driver to avoid disrupting the boot up state of
>> regulators that are needed by other subsystems.  Therefore, I would like
>> to keep the initial voltage feature supported.
> 
> I was asking for specific examples.  Do you have any?

I was able to track down an example that requires initialization at a
non-minimum voltage: PM8998 LDO 13 on SDM845 MTP.  This regulator supplies
the microSD card with a voltage in the range 1.8 V to 2.96 V.  The boot
loader leaves this regulator enabled at 2.96 V.  It is only guaranteed to
be safe to reduce the voltage to 1.8 V on UHS type cards and only after
following the proper SD identification and command sequence.


> BTW: have I already said how terrible of a design it is that you can't
> read back the voltages that the BIOS set?  If we could just read back
> what the BIOS set then everything would work great and we could stop
> talking about this.

Even if such reading were feasible, it would not help the situation
substantially.  Very few requests are made via the AP RSC before Linux
kernel boot, so 0 V values would still be read back for most regulators.
Additionally, reading the true hardware state (as opposed to what AP RSC
voted before Linux boot) would also not be helpful.  For example, if a
regulator was physically enabled due to a vote via modem RSC and
qcom-rpmh-regulator returned is_enabled() == true inside of a
regulator_enable() call, then no enable request would be made via the AP
RSC which would result in the regulator turning off unexpectedly later
when the modem requests to disable the regulator.

Take care,
David

[1]:
https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/drivers/regulator/rpmh-regulator.c?h=msm-4.9

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
