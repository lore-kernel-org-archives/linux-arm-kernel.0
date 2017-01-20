From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 20 Jan 2017 14:18:40 +0000
Subject: [PATCH v3 2/4] dt-bindings: Add TI SCI PM Domains
In-Reply-To: <CAPDyKFqzs59N5bc89X-96Fgy9b=_+s8zYmHHshQeDrJCnaqprA@mail.gmail.com>
References: <20170104205536.15963-1-d-gerlach@ti.com>
 <20170104205536.15963-3-d-gerlach@ti.com>
 <20170109175012.sg7eze7llqq7qevd@rob-hp-laptop>
 <7bd282d9-df6f-f4c6-1f7f-c8ed81c78af3@ti.com>
 <CAL_JsqKxU4c=KSn0=xX9kmbk498fhqpiXMeGjcoe8Ah48FAzUg@mail.gmail.com>
 <3bb89649-fd2a-acc6-6968-e54a00842ce2@ti.com>
 <CAL_JsqL+L1oHAOv7tLevzbtRFSKRs9J01SgF=HR_vNNqNV+4+Q@mail.gmail.com>
 <84d7d49b-933b-8b26-f18a-3a5054738cb1@ti.com>
 <CAL_JsqJ9RitNC7ihC8ckJgV+49kaHk=W9tgdNBSjEfydhQS46A@mail.gmail.com>
 <0eaa9914-83f1-7716-cf04-1e3dd44df647@ti.com>
 <4cb25cf9-216f-2e18-f45d-ef7e48fa6c5e@ti.com> <m2ziip2puf.fsf@baylibre.com>
 <CAL_Jsq+Vp8iYrAUmuSRzeeY_G6CUqFqG6XB6erDxo1RYo3g4=g@mail.gmail.com>
 <CAPDyKFqzs59N5bc89X-96Fgy9b=_+s8zYmHHshQeDrJCnaqprA@mail.gmail.com>
Message-ID: <c31cffa6-160a-de29-4ee7-fd74fc9cc743@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/01/17 14:00, Ulf Hansson wrote:
> + Sudeep
> 
> On 19 January 2017 at 00:03, Rob Herring <robh@kernel.org> wrote:

>>
>> We could continue to use the power domain binding (maybe we already
>> are and that ship has sailed). I'm not totally against the idea even
>> if there is no power domain, but I'm not sold on it either. If we do
>> go this route, then I still say the id should be a cell in the
>> power-domain phandle.
>>
>> Another option is create something new either common or TI SCI
>> specific. It could be just a table of ids and phandles in the SCI
>> node. I'm much more comfortable with an isolated property in one node
>> than something scattered throughout the DT.
> 
> To me, this seems like the best possible solution.
> 
> However, perhaps we should also consider the SCPI Generic power domain
> (drivers/firmware/scpi_pm_domain.c), because I believe it's closely
> related.
> To change the power state of a device, this PM domain calls
> scpi_device_set|get_power_state() (drivers/firmware/arm_scpi.c), which
> also needs a device id as a parameter. Very similar to our case with
> the TI SCI domain.
> 
> Currently these SCPI device ids lacks corresponding DT bindings, so
> the scpi_pm_domain tries to work around it by assigning ids
> dynamically at genpd creation time.
> 

IIUC do you mean the binding for the power domain provider to have a
list of domain ids ? If so yes, we don't have one.

But the idea was to have the range to be continuous and create genpd for
the complete range. Though the SCPI specification lacked a command to
get the max. no. of domains supported. That's the reason we had to
introduce the num-domains(*) which may be optional if we have firmware
interface to obtain that information.

-- 
Regards,
Sudeep

(*) P.S: but it has been considered for SCMI(which is an improvement and
more flexible/extensible replacement/upgrade to SCPI) which will be
released soon.
