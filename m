From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 24 Feb 2015 10:21:55 +0100
Subject: [RFC PATCH 1/3] eeprom: Add a simple EEPROM framework
In-Reply-To: <54EBB3AC.30000@codeaurora.org>
References: <1424365639-26634-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1424365708-26681-1-git-send-email-srinivas.kandagatla@linaro.org>
 <CAL_Jsq+SeuoojgTpv1y_aPJ_jzDr3HqZhYEBQ3_vYGBHvcccug@mail.gmail.com>
 <54E78A31.9020306@linaro.org>
 <CAL_Jsq+mvpRjYfL_8OseTDCB-6aBhwhNKLBQXXJeVQLDwWm8Nw@mail.gmail.com>
 <20150222143211.GX25269@lukather>
 <CAL_JsqLqqw5DyUqCaOTSKPwF-Ms5EU4f_OPoW9YVpMCo8A_bbw@mail.gmail.com>
 <54EBB3AC.30000@codeaurora.org>
Message-ID: <20150224092155.GO25269@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 23, 2015 at 03:11:40PM -0800, Stephen Boyd wrote:
> >>> I would do something more simple that is just a list of keys and
> >>> their location like this:
> >>>
> >>> device-serial-number = <start size>;
> >>> key1 = <start size>;
> >>> key2 = <start size>;
> >> I'm sorry, but what's the difference?
> > It can describe the layout completely whether the fields are tied to a
> > h/w device or not.
> >
> > What I would like to see here is the entire layout described covering
> > both types of fields.
> >
> 
> I was thinking the DT might be like this on the provider side:
> 
>    qfprom at 1000000 {
>       reg = <0x1000000 0x1000>;
>       ranges = <0 0x1000000 0x1000>;
>       compatible = "qcom,qfprom-msm8960"
> 
>       pvs-data: pvs-data at 40 {
>             compatible = "qcom,pvs-a";
>             reg = <0x40 0x20>,
> 	    #eeprom-cells = <0>;
>       };
> 
>        tsens-data: tmdata at 10 {
>             compatible = "qcom,tsens-data-msm8960";
>             reg = <0x10 4>, <0x16 4>;
> 	    #eeprom-cells = <0>;
> 
>       };
> 
>       serial-number: serial at 50 {
>             compatible = "qcom,serial-msm8960";
>             reg = <0x50 4>, <0x60 4>;
> 	    #eeprom-cells = <0>;
> 
>       };
>    };

I'm not sure the compatible is really needed.

A label of some sort, just like the MTD partitions do would do just
fine, and wouldn't have the implicit expectation that a driver will be
probed from that node.

> and then on the consumer side:
> 
> 	device {
> 		eeproms = <&serial-number>;
> 		eeprom-names = "soc-rev-id";
> 	};
> 
> 
> This would solve a problem where the consumer device is some standard
> off-the-shelf IP block that needs to get some SoC specific calibration
> data from the eeprom. I may want to interpret the bits differently
> depending on which eeprom is connected to my SoC. Sometimes that data
> format may be the same across many variations of the SoC (e.g. the
> qcom,pvs-a node) or it may be completely different for a given SoC (e.g.
> qcom,serial-msm8960 node). I imagine for other SoCs out there it could
> be different depending on which eeprom the board manufacturer decides to
> wire onto their board and how they choose to program the data.

Oh, so you'd like to infer the data format it's stored in from the
compatible?

AFAICT, this format will be highly depending on the board itself,
rather than on the SoC, do you think it will scale enough?

> So this is where I think the eeprom-cells and offset + length starts to
> fall apart. It forces us to make up a bunch of different compatible
> strings for our consumer device just so that we can parse the eeprom
> that we decided to use for some SoC/board specific data. Instead I'd
> like to see some framework that expresses exactly which eeprom is on my
> board and how to interpret the bits in a way that doesn't require me to
> keep refining the compatible string for my generic IP block.

Hmmmm, apparently you don't :)

> I worry that if we put all those details in DT we'll end up having to
> describe individual bits like serial-number-bit-2, serial-number-bit-3,
> etc. because sometimes these pieces of data are scattered all around the
> eeprom and aren't contiguous or aligned on a byte boundary. It may be
> easier to just have a way to express that this is an eeprom with this
> specific layout and my device has data stored in there. Then the driver
> can be told what layout it is (via compatible or some other string based
> means if we're not using DT?) and match that up with some driver data if
> it needs to know how to understand the bits it can read with the
> eeprom_read() API.

I'm half convinced that the layout information will actually work for
more complex cases, like the linked list Rob described.

If such a structure is ever to be found, it would feel wrong to have
that in the EEPROM driver, but it would feel just as wrong to put that
in the client driver, that would have to handle the parsing of raw
data coming flashed by one single crazy board vendor.

Maybe we can have each cell carry a property that defines the format
it's stored in, and match that to some parsers plugins, starting with
the generic and trivial cases but still allowing for custom parsers to
be defined?

Something like

eeprom at 42 {
	compatible = "atmel,at24something";
	reg = <0x42>;

	serial at 0 {
		label = "board serial";
		reg = <0x0 0x10>;
		format = "packed";
	};

	opps at 10 {
		label = "board serial";
		reg = <0x10 0x10>, <0x40 0x10>, <0x80 0x10>;
		format = "random-vendor,opp-linked-list";
	};
};

That would make eeprom_read always return the same format of data to
the client drivers, without cripling the generic EEPROM drivers
either.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150224/7139a89c/attachment-0001.sig>
