From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Fri, 17 Oct 2014 06:55:55 -0700
Subject: [RFC 6/7] mfd: qcom-smd-rpm: Driver for the Qualcomm RPM over SMD
In-Reply-To: <20141008084017.GD20647@lee--X1>
References: <1412037291-16880-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1412037291-16880-7-git-send-email-bjorn.andersson@sonymobile.com>
 <20141008084017.GD20647@lee--X1>
Message-ID: <20141017135553.GA28882@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 08 Oct 01:40 PDT 2014, Lee Jones wrote:

Hi Lee,

Thanks for your review.

> On Mon, 29 Sep 2014, Bjorn Andersson wrote:
> 
[..]

> > +#define RPM_ERR_INVALID_RESOURCE "resource does not exist"
> > +
> > +static bool qcom_rpm_msg_is_invalid_resource(struct qcom_rpm_message *msg)
> > +{
> > +	size_t msg_len = sizeof(RPM_ERR_INVALID_RESOURCE) - 1;
> > +
> > +	if (msg->length != msg_len)
> > +		return false;
> > +
> > +	if (memcmp(msg->message, RPM_ERR_INVALID_RESOURCE, msg_len))
> > +		return false;
> > +
> > +	return true;
> > +}
> 
> You can save yourself a hell of a lot of code by just doing:
> 
> if (memcmp(msg->message, RPM_ERR_INVALID_RESOURCE,
>            min(msg_len, sizeof(RPM_ERR_INVALID_RESOURCE))))
> 
> ... in qcom_smd_rpm_callback().
> 

I can agree with you that there will be less code, but not "a hell of a lot". I
made the choise because I had something like the snippet you suggest and I
wanted to make it cleaner - I'll fold it back in.

> [...]
> 
> > +static int qcom_smd_rpm_probe(struct qcom_smd_device *sdev)
> > +{
> > +	const struct of_device_id *match;
> > +	struct qcom_smd_rpm *rpm;
> > +
> > +	rpm = devm_kzalloc(&sdev->dev, sizeof(*rpm), GFP_KERNEL);
> > +	if (!rpm)
> > +		return -ENOMEM;
> > +
> > +	rpm->dev = &sdev->dev;
> > +	mutex_init(&rpm->lock);
> > +	init_completion(&rpm->ack);
> > +
> > +	match = of_match_device(qcom_smd_rpm_of_match, &sdev->dev);
> 
> You need to check the return value here.
> 

As long as we only support device tree probing of this match will never return
NULL. I can add a check to fail on non-dt boards if someone chooses to ever
implement one of those.

> > +	rpm->data = match->data;
> > +	rpm->rpm_channel = sdev->channel;
> > +
> > +	dev_set_drvdata(&sdev->dev, rpm);
> > +
> > +	dev_info(&sdev->dev, "Qualcomm SMD RPM driver probed\n");
> 
> Please remove this line.
> 

Ok

> > +	return of_platform_populate(sdev->dev.of_node, NULL, NULL, &sdev->dev);
> > +}
> > +
> > +static void qcom_smd_rpm_remove(struct qcom_smd_device *sdev)
> > +{
> > +	dev_set_drvdata(&sdev->dev, NULL);
> 
> If you use the proper platform device interface you don't have to do
> this.
> 

Ok

> > +	of_platform_depopulate(&sdev->dev);
> > +}
> > +
> > +static struct qcom_smd_driver qcom_smd_rpm_driver = {
> > +	.probe = qcom_smd_rpm_probe,
> > +	.remove = qcom_smd_rpm_remove,
> > +	.callback = qcom_smd_rpm_callback,
> > +	.driver  = {
> > +		.name  = "qcom_smd_rpm",
> > +		.owner = THIS_MODULE,
> > +		.of_match_table = qcom_smd_rpm_of_match,
> > +	},
> > +};
> > +
> > +module_qcom_smd_driver(qcom_smd_rpm_driver);
> 
> I don't like this.  What's wrong with the existing platform driver
> code?
> 

I started off with having smd child devices as platform drivers and had some
accessor functions to find the open handles that triggered the probe() and
register the callback with those. But this didn't feel very sane, so I did
implemented a custom driver struct and probe prototype to simplify writing
drivers.

May I ask why you dislike this? This is how it's done in so many other places
in the kernel...

Regards,
Bjorn
