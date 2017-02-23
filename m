From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Wed, 22 Feb 2017 16:09:23 -0800
Subject: [PATCH v4 23/36] media: imx: Add MIPI CSI-2 Receiver subdev driver
In-Reply-To: <20b7d3b7-85be-b701-19ca-1e8024260fc2@gmail.com>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-24-git-send-email-steve_longerbeam@mentor.com>
 <1487328479.3107.21.camel@pengutronix.de>
 <20170217110616.GD21222@n2100.armlinux.org.uk>
 <20b7d3b7-85be-b701-19ca-1e8024260fc2@gmail.com>
Message-ID: <80ecf2ef-8e52-0c60-87b5-8325571857ee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/22/2017 04:06 PM, Steve Longerbeam wrote:
>
>
> On 02/17/2017 03:06 AM, Russell King - ARM Linux wrote:
>> On Fri, Feb 17, 2017 at 11:47:59AM +0100, Philipp Zabel wrote:
>>> On Wed, 2017-02-15 at 18:19 -0800, Steve Longerbeam wrote:
>>>> +static void csi2_dphy_init(struct csi2_dev *csi2)
>>>> +{
>>>> +    /*
>>>> +     * FIXME: 0x14 is derived from a fixed D-PHY reference
>>>> +     * clock from the HSI_TX PLL, and a fixed target lane max
>>>> +     * bandwidth of 300 Mbps. This value should be derived
>>>
>>> If the table in https://community.nxp.com/docs/DOC-94312 is correct,
>>> this should be 850 Mbps. Where does this 300 Mbps value come from?
>>
>> I thought you had some code to compute the correct value, although
>> I guess we've lost the ability to know how fast the sensor is going
>> to drive the link.
>>
>> Note that the IMX219 currently drives the data lanes at 912Mbps almost
>> exclusively, as I've yet to finish working out how to derive the PLL
>> parameters.  (I have something that works, but it currently takes on
>> the order of 100k iterations to derive the parameters.  gcd() doesn't
>> help you in this instance.)
>
> Hi Russell,
>
> As I mentioned, I've added code to imx6-mipi-csi2 to determine the
> sources link frequency via V4L2_CID_LINK_FREQ. If you were to implement
> this control and return 912 Mbps-per-lane,

argh, I mean return 912 / 2.

Steve

  the D-PHY will be programmed
> correctly for the IMX219 (at least, that is the theory anyway).
>
> Alternatively, I could up the default in imx6-mipi-csi2 to 950
> Mbps. I will have to test that to make sure it still works with
> OV5640 and tc358743.
>
> Steve
