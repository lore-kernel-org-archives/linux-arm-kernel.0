From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 22 Feb 2015 15:32:11 +0100
Subject: [RFC PATCH 1/3] eeprom: Add a simple EEPROM framework
In-Reply-To: <CAL_Jsq+mvpRjYfL_8OseTDCB-6aBhwhNKLBQXXJeVQLDwWm8Nw@mail.gmail.com>
References: <1424365639-26634-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1424365708-26681-1-git-send-email-srinivas.kandagatla@linaro.org>
 <CAL_Jsq+SeuoojgTpv1y_aPJ_jzDr3HqZhYEBQ3_vYGBHvcccug@mail.gmail.com>
 <54E78A31.9020306@linaro.org>
 <CAL_Jsq+mvpRjYfL_8OseTDCB-6aBhwhNKLBQXXJeVQLDwWm8Nw@mail.gmail.com>
Message-ID: <20150222143211.GX25269@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 04:01:55PM -0600, Rob Herring wrote:
> [...]
> 
> >>> += Data consumers =
> >>> +
> >>> +Required properties:
> >>> +
> >>> +eeproms: List of phandle and data cell specifier triplet, one triplet
> >>> +        for each data cell the device might be interested in. The
> >>> +        triplet consists of the phandle to the eeprom provider, then
> >>> +        the offset in byte within that storage device, and the length
> >>> +        in byte of the data we care about.
> >>
> >>
> >> The problem with this is it assumes you know who the consumer is and
> >> that it is a DT node. For example, how would you describe a serial
> >> number?
> >
> > Correct me if I miss understood.
> > Is serial number any different?
> > Am hoping that the eeprom consumer would be aware of offset and size of
> > serial number in the eeprom
> >
> > Cant the consumer do:
> >
> > eeprom-consumer {
> >         eeproms = <&at24 0 4>;
> >         eeprom-names = "device-serial-number";
> 
> Yes, but who is "eeprom-consumer"?

Any device that should lookup values in one of the EEPROM.

> DT nodes generally describe a h/w block, but it this case, the
> consumer depends on the OS, not the h/w. 

Not really, or at least, not more than any similar binding we
currently have.

The fact that a MAC-address for the first ethernet chip is stored at a
given offset in a given eeprom has nothing to do with the OS.

> I'm not saying you can't describe where things are, but I don't
> think you should imply who is the consumer and doing so is
> unnecessarily complicated.

If you only take the case of a serial number, indeed. If you take
other usage into account, you can't really do without it.

> Also, the layout of EEPROM is likely very much platform specific.

Indeed, which is why it should be in the DT.

> Some could have a more complex structure perhaps with key ids and
> linked list structure.

Then just request the size of the whole list, and parse it afterwards
in your driver?

> I would do something more simple that is just a list of keys and their
> location like this:
> 
> device-serial-number = <start size>;
> key1 = <start size>;
> key2 = <start size>;

I'm sorry, but what's the difference?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150222/56c06781/attachment.sig>
