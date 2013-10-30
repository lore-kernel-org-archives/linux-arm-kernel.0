From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 30 Oct 2013 12:45:57 -0700
Subject: [PATCH v3 02/10] spmi: Linux driver framework for SPMI
In-Reply-To: <20131030193717.GP20207@joshc.qualcomm.com>
References: <cover.1382985169.git.joshc@codeaurora.org>
 <149bbfe89e37376cc176c3aeb6c1fab9e4fd2b91.1382985169.git.joshc@codeaurora.org>
 <526FE7BF.1060402@codeaurora.org> <20131030193717.GP20207@joshc.qualcomm.com>
Message-ID: <527161F5.8060507@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/13 12:37, Josh Cartwright wrote:
> On Tue, Oct 29, 2013 at 09:52:15AM -0700, Stephen Boyd wrote:
>> On 10/28/13 11:12, Josh Cartwright wrote:
>>> +int spmi_register_read(struct spmi_device *sdev, u8 addr, u8 *buf)
>>> +{
>>> +	/* 5-bit register address */
>>> +	if (addr > 0x1F)
>> Perhaps 0x1f should be a #define.
> Is 0x1F with the comment above it not clear enough?

It triggered my 'magic number used twice' alarm. I'm ok with it either way.

>>> +struct spmi_controller *spmi_controller_alloc(struct device *parent,
>>> +					      size_t size)
>>> +{
>>> +	struct spmi_controller *ctrl;
>>> +	int id;
>>> +
>>> +	if (WARN_ON(!parent))
>>> +		return NULL;
>>> +
>>> +	ctrl = kzalloc(sizeof(*ctrl) + size, GFP_KERNEL);
>>> +	if (!ctrl)
>>> +		return NULL;
>>> +
>>> +	device_initialize(&ctrl->dev);
>>> +	ctrl->dev.type = &spmi_ctrl_type;
>>> +	ctrl->dev.bus = &spmi_bus_type;
>>> +	ctrl->dev.parent = parent;
>>> +	ctrl->dev.of_node = parent->of_node;
>>> +	spmi_controller_set_drvdata(ctrl, &ctrl[1]);
>>> +
>>> +	idr_preload(GFP_KERNEL);
>>> +	mutex_lock(&ctrl_idr_lock);
>>> +	id = idr_alloc(&ctrl_idr, ctrl, 0, 0, GFP_NOWAIT);
>>> +	mutex_unlock(&ctrl_idr_lock);
>>> +	idr_preload_end();
>> This can just be:
>>
>>     mutex_lock(&ctrl_idr_lock);
>>     id = idr_alloc(&ctrl_idr, ctrl, 0, 0, GFP_KERNEL);
>>     mutex_unlock(&ctrl_idr_lock);
> Actually, I'm wondering if it's just easier to leverage the simpler
> ida_simple_* APIs instead.

Yes that also works.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
