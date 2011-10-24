From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 24 Oct 2011 14:43:58 +0530
Subject: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <20111024091158.GB1755@S2100-06.ap.freescale.net>
References: <4E9FAF42.5060200@ti.com>
	<20111020061408.GE32007@S2100-06.ap.freescale.net>
	<4EA00F7C.1080005@ti.com>
	<20111021082309.GA337@S2100-06.ap.freescale.net>
	<4EA13053.7080306@ti.com>
	<20111021115809.GB337@S2100-06.ap.freescale.net>
	<4EA4FF6B.2080906@ti.com>
	<20111024081706.GC8708@ponder.secretlab.ca>
	<20111024090228.GA1755@S2100-06.ap.freescale.net>
	<4EA52851.8000203@ti.com>
	<20111024091158.GB1755@S2100-06.ap.freescale.net>
Message-ID: <4EA52C56.3080908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 October 2011 02:41 PM, Shawn Guo wrote:
> On Mon, Oct 24, 2011 at 02:26:49PM +0530, Rajendra Nayak wrote:
>> On Monday 24 October 2011 02:32 PM, Shawn Guo wrote:
>>> Okay, it's wrong then since so many people say it's wrong :)  I guess
>>> a quick fix would be adding one property in device tree node for
>>> matching some unique field in regulator_desc, id, maybe?  Mark, any
>>> suggestion?
>>
>> Thats basically what the DT compatible property is for :)
>
> But adding compatible property will get DT core create 'struct dev'
> for each regulator node, while we are trying to avoid that since
> regulator core has been doing this.
>
No it won't.

So here's what I am suggesting.

Case 1:
One device per regulator:

DT nodes look something like this

reg1: reg at 1 {
		...
		...
};

reg2: reg at 2 {
		...
		...
};

The regulator driver probes 2 devices and each time the
dev passed has a of_node associated which the regulator
driver can then pass to the core.

Case 2:
One device for all regulators:

DT nodes look something like this

regulators {
	reg1: reg at 1 {
			...
			...
	};

	reg2: reg at 2 {
			...
			...
	};
};

The regulator driver probes only one device and the dev->of_node
points to the "regulators" node above.
The regulator driver then based on compatible property extracts
and registers all the child nodes of "regulators" (for ex: reg1, reg2
above) with each call to regulator_register and passes the child nodes
as of_node to be associated with the regulator device.
