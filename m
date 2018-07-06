From: mbrugger@suse.com (Matthias Brugger)
Date: Fri, 6 Jul 2018 15:18:44 +0200
Subject: [v3 03/10] mfd: mtk-mmsys: Add mmsys driver
In-Reply-To: <20180705122223.GO496@dell>
References: <cover.1524820923.git.mbrugger@suse.com>
 <e0894c97775e46ce6d9a441dc05e2e2479a4b612.1524820923.git.mbrugger@suse.com>
 <20180430101826.GC5147@dell> <5269ccfd-0274-3c12-7eeb-5de923197d92@gmail.com>
 <20180703071103.GE20176@dell> <b6301691-a9f6-64fe-dd8a-ffe51fad6799@suse.com>
 <20180704164540.GH496@dell> <92a851a9-a12c-e773-5f43-007f4d08b7e3@suse.com>
 <20180705122223.GO496@dell>
Message-ID: <9c368450-b89b-825b-4763-90825e93b656@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/07/18 14:22, Lee Jones wrote:
> On Thu, 05 Jul 2018, Matthias Brugger wrote:
>> On 04/07/18 18:45, Lee Jones wrote:
>>> On Wed, 04 Jul 2018, Matthias Brugger wrote:
>>>> On 03/07/18 09:11, Lee Jones wrote:
>>>>> On Mon, 25 Jun 2018, Matthias Brugger wrote:
>>>>>> On 30/04/18 12:18, Lee Jones wrote:
>>>>>>> On Fri, 27 Apr 2018, matthias.bgg at kernel.org wrote:
[...]
>>>>>>>> +static int mmsys_probe(struct platform_device *pdev)
>>>>>>>> +{
>>>>>>>> +	const struct mfd_cell *mmsys_cells;
>>>>>>>> +	int nr_cells;
>>>>>>>> +	long id;
>>>>>>>> +	int ret;
>>>>>>>> +
>>>>>>>> +	id = (long) of_device_get_match_data(&pdev->dev);
>>>>>>>> +	if (!id) {
>>>>>>>> +		dev_err(&pdev->dev, "of_device_get match_data() failed\n");
>>>>>>>> +		return -EINVAL;
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>> +	switch (id) {
>>>>>>>> +	case MMSYS_MT2701:
>>>>>>>> +		mmsys_cells = mmsys_mt2701_devs;
>>>>>>>> +		nr_cells = ARRAY_SIZE(mmsys_mt2701_devs);
>>>>>>>> +		break;
>>>>>>>> +	default:
>>>>>>>> +		return -ENODEV;
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>> +	ret = devm_mfd_add_devices(&pdev->dev, 0, mmsys_cells, nr_cells,
>>>>>>>> +					NULL, 0, NULL);
>>>>>>>> +	if (ret) {
>>>>>>>> +		dev_err(&pdev->dev, "failed to add MFD devices %d\n", ret);
>>>>>>>> +		return ret;
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>> +	return 0;
>>>>>>>> +};
>>>>>>>
>>>>>>> This driver is pretty pointless.  It doesn't actually do anything.
>>>>>>>
>>>>>>> I think you just want to use "simple-mfd" instead.
>>>>>>>
>>>>>>
>>>>>> I think the problem is, that right now we have two drivers which use the same
>>>>>> devicetree binding, which are clk and drm driver. With a simple-mfd we would
>>>>>> need two compatibles, and this would break backwards compatibility.
>>>>>
>>>>> So what functionality does this driver provide you with that you do
>>>>> not have currently?
>>>>>
>>>>
>>>> I'm not sure if I get your question. Point is, that the MMSYS implementation for
>>>> mt8173 is broken, as it assumes that we can probe two drivers with the
>>>> mediatek,mt8173-mmsys compatible. Somehow it used to work, but from what I
>>>> understand it was a bug. So older devicetrees use just on mt8173-mmsys
>>>> compatible in ther DTB.
>>>
>>> Okay, that is what I was getting at.  Thanks for the explanation.
>>>
>>> Do you have a datasheet I can look at?
>>>
>>
>> Unfortunately there is no datasheet you can get without a NDA. The only public
>> available information I'm aware of is for the (not upstream supported) 96board
>> [1]. And it's only the register description. You can find some more explanation
>> about the MMSYS in older threads which tried to solve the very same problem [2]
>>
>> [1]
>> https://www.96boards.org/documentation/consumer/mediatekx20/additional-docs/docs/MT6797_Register_Table_Part_2.pdf
>> [2] http://lists.infradead.org/pipermail/linux-mediatek/2017-October/010979.html
> 
> And now we have some history.  Thanks for providing those.
> 
> So my initial reaction is the one I have just confirmed for myself.
> MFD is being used as a work-around in this odd use-case and really
> isn't the right place for it.
> 
> If you're adamant that you do not wish to change the Device Tree, my
> suggestion is to either move the clk functionality into the DRM
> driver, or register the clk driver from DRM using standard
> platform_device_register() API.
> 

Ok, I'll try to come up with a solution with a platform device for the clocks.
Stay tuened. Thanks for your feedback!

Matthias
