From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 16 Jan 2012 13:04:58 -0700 (MST)
Subject: [PATCH v6 0/6] PM QoS: implement the OMAP low level constraints
 management code
In-Reply-To: <CAORVsuVNvvPu6it7r_uxc0f6H-9kpo6SChTTGkdqpLmzMDNxvQ@mail.gmail.com>
References: <1323874304-5001-1-git-send-email-j-pihet@ti.com>
 <alpine.DEB.2.00.1112191337420.12660@utopia.booyaka.com>
 <CAORVsuVNvvPu6it7r_uxc0f6H-9kpo6SChTTGkdqpLmzMDNxvQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1201161301450.16675@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Mon, 16 Jan 2012, Jean Pihet wrote:

> Speaking of the locking, currently a spinlock is used and it could be
> replaced by a more efficient mutex. This is ok at the condition that
> this code is not called from interrupt context?
> 
> Kevin,
> Do you know if the per-device constraint code can be called from
> interrupt context?

It can't be.  It uses a mutex itself.  So a mutex is what we want.  Take a 
look at drivers/base/power/qos.c:dev_pm_qos_update_request() (included 
below)


- Paul


/**
 * dev_pm_qos_update_request - modifies an existing qos request
 * @req : handle to list element holding a dev_pm_qos request to use
 * @new_value: defines the qos request
 *
 * Updates an existing dev PM qos request along with updating the
 * target value.
 *
 * Attempts are made to make this code callable on hot code paths.
 *
 * Returns 1 if the aggregated constraint value has changed,
 * 0 if the aggregated constraint value has not changed,
 * -EINVAL in case of wrong parameters, -ENODEV if the device has been
 * removed from the system
 */
int dev_pm_qos_update_request(struct dev_pm_qos_request *req,
			      s32 new_value)
{
	int ret = 0;

	if (!req) /*guard against callers passing in null */
		return -EINVAL;

	if (WARN(!dev_pm_qos_request_active(req),
		 "%s() called for unknown object\n", __func__))
		return -EINVAL;

	mutex_lock(&dev_pm_qos_mtx);

	if (req->dev->power.constraints) {
		if (new_value != req->node.prio)
			ret = apply_constraint(req, PM_QOS_UPDATE_REQ,
					       new_value);
	} else {
		/* Return if the device has been removed */
		ret = -ENODEV;
	}

	mutex_unlock(&dev_pm_qos_mtx);
	return ret;
}
