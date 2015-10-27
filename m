From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 27 Oct 2015 16:24:48 -0500
Subject: [PATCH v6 03/22] of/platform: Point to struct device from device
 node
In-Reply-To: <3956941.s3nuWak5tq@vostro.rjw.lan>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <1806288.pmhamH8mKQ@vostro.rjw.lan>
 <CAAObsKBjNZMhKn2bUMmQO8Lvrqfucnf9dXqmbfQ2DbAc6_GvcQ@mail.gmail.com>
 <3956941.s3nuWak5tq@vostro.rjw.lan>
Message-ID: <CAL_JsqJxqJc=0tDDCxx-2rGLLUVE50u+P3CrvptBCkskHdV2tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2015 at 10:43 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, October 27, 2015 03:48:40 PM Tomeu Vizoso wrote:
>> On 24 October 2015 at 15:57, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> [...]
>
>> >
>> > Well, once that has happened, your new device pointer in the given device_node
>> > becomes useless.  Why exactly is that fine?
>>
>> Why do you think it's useless? It's the device that was registered
>> from that device_node. The other one just happens to want to point to
>> the same device_node for whatever other reason, but I don't see how is
>> that relevant.
>
> It is useless as a reverse mapping from OF nodes to devices.  It tells us
> which device pointing to the given device node has been found first, but
> that's just it.
>
> You can't say whether or not it is special in any way with respect to the
> other devices hanging out of the same OF node unless you have some additional
> information on how those devices are related to each other.

As Tomeu says this struct device is the one created from scanning the
DT. There should never be more than one. Now some drivers create sub
devices and maybe they set the DT node on the child devices, but that
is wrong. Doing that would also break the current code:

struct platform_device *of_find_device_by_node(struct device_node *np)
{
        struct device *dev;

        dev = bus_find_device(&platform_bus_type, NULL, np, of_dev_node_match);
        return dev ? to_platform_device(dev) : NULL;
}

I can't think of any other possible cases.

Rob
