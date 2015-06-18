From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 18 Jun 2015 16:38:59 +0200
Subject: [PATCH 00/13] Discover and probe dependencies
In-Reply-To: <5582C437.4030108@samsung.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
 <55829269.2090309@samsung.com> <20150618103615.GC14071@sirena.org.uk>
 <5582C437.4030108@samsung.com>
Message-ID: <CAAObsKAERGvt=tECODWmUTrJOhxi_RpCfZ1d6h83vrgPMOxmEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 June 2015 at 15:14, Andrzej Hajda <a.hajda@samsung.com> wrote:
> On 06/18/2015 12:36 PM, Mark Brown wrote:
>> On Thu, Jun 18, 2015 at 11:42:01AM +0200, Andrzej Hajda wrote:
>>
>> There's something really messed up with how your mailer is word wrapping
>> paragraphs, might want to check it out - it looks like it's making lines
>> that are longer than 80 columns and then randomly breaking them 80
>> columns in rather than reflowing things.
>>
>>> 3. Dependencies are mandatory, ie without it driver will not be able to
>>> successfully finish
>>> the probe.
>>>     It should be not true. Sometimes device will require given resource
>>> only in specific
>>>     scenario, or it can still probe successfully and ask for the
>>> resource later.
>>>     I can also imagine that firmware can describe more information than
>>> given driver require,
>>>     some resources even if they are present in the dts, will be not
>>> requested by the driver, it
>>>     can be the case of drivers providing limited functionality, or just
>>> obsolete bindings.
>> Well, this isn't clear - the model here seems to be that the
>> dependencies are those that are explicitly listed for a given platform.
>> For those our current expectation is that we will try to control them
>> and will defer probe until the resources that are mapped in on the
>> platform are present so this doesn't seem like a change.
> IMO current assumption is that we CAN TRY to control them
> and we MAY defer probe until resource is present, nothing mandatory.
>
> Lets look at more real example: we have HDMI encoder which can
> use some video and audio resources provided by some video and audio
> drivers. If we know that our machine will work without sound we can
> disable audio drivers but we can expect video should still work, ie HDMI
> driver should successfully probe even if audio resources are not available.
>
> I had an impression that in this patchset the device wont be probed
> until all dependencies are present, but after looking at the code it
> does not seems to be true - in case dependency cannot be probed
> warning will be printed but the probe will continue, so it should handle
> scenario above properly.

Yeah, I think deferred probe is a very good way to make sure that we
get a working system at the end. It's just that as we probe devices in
a random order, we'd get a lot of noise if we printed something every
time a device failed to find a resource and deferred its probe.

You can see these series as just changing the order in which we probe
devices, to one in which dependencies are probed before the device
that depends on them.

> The only minor issue is that we will see
> sometimes misleading message about missing dependencies.

Yes, that's why they are currently pr_debug and not pr_warn. I think
that once we have tables specifying the resources needed by each
driver (ala devm_probe), we can know which are optional and print
appropriate warnings accordingly.

Thanks,

Tomeu

> Regards
> Andrzej
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
