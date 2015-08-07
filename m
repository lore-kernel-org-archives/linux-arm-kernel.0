From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Fri, 7 Aug 2015 09:11:23 +0200
Subject: [PATCH v3 01/18] platform: delay OF device-driver matches until
 late_initcall
In-Reply-To: <CAL_Jsq+GLMZe-f6qEi=7i1YrrWc6k99RpGkOyCd5KkYDiyt0QA@mail.gmail.com>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438870315-18689-2-git-send-email-tomeu.vizoso@collabora.com>
 <CAL_Jsq+GLMZe-f6qEi=7i1YrrWc6k99RpGkOyCd5KkYDiyt0QA@mail.gmail.com>
Message-ID: <CAAObsKBapFqzr+4YEXJfcJWMd+tkaBqYbGiFTntHStAP=+P-_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 August 2015 at 22:19, Rob Herring <robherring2@gmail.com> wrote:
> On Thu, Aug 6, 2015 at 9:11 AM, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>> Delay matches of platform devices with OF nodes until late_initcall,
>> when we are sure that all built-in drivers have been registered already.
>> This is needed to prevent deferred probes because of some drivers not
>> having registered yet.
>>
>> The reason why only platform devices are delayed is that some other
>> devices are expected to be probed earlier than late_initcall, for
>> example, the system PNP driver needs to probe its devices in
>> fs_initcall.
>>
>> Additionally, only platform devices with OF nodes are delayed because
>> some machines may depend on oter platform devices being registered at
>> specific times.
>
> How do we know that these probes occur before the unused clocks and
> regulators are turned off? Just getting lucky (as is deferred probe)?
> Can we do this one level earlier so we have a level left to do things
> after probe.

Those are already late_initcall_sync so I guess we're fine.

Thanks,

Tomeu

> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
