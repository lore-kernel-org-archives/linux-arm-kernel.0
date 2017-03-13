From: shiju.jose@huawei.com (Shiju Jose)
Date: Mon, 13 Mar 2017 09:39:28 +0000
Subject: {RFC PATCH v1 v4.11-rc1 1/1} acpi: apei: common handler in ghes
 for HW errors notified via hed(PNP0C33) driver
In-Reply-To: <58C2DF6C.6000900@arm.com>
References: <86258A5CC0A3704780874CF6004BA8A62DCAF445@lhreml502-mbs>
 <58C2DF6C.6000900@arm.com>
Message-ID: <86258A5CC0A3704780874CF6004BA8A62DCB5C0F@lhreml502-mbx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

Thanks for the comments.

> -----Original Message-----
> From: James Morse [mailto:james.morse at arm.com]
> Sent: 10 March 2017 17:16
> To: Shiju Jose
> Cc: catalin.marinas at arm.com; will.deacon at arm.com;
> tbaicar at codeaurora.org; zjzhang at codeaurora.org; marc.zyngier at arm.com;
> xuwei (O); Gabriele Paoloni; John Garry; Guohanjun (Hanjun Guo);
> Zhengqiang (turing); Xiexiuqi; fu.wei at linaro.org; wangxiongfeng (C);
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> linux-acpi at vger.kernel.org
> Subject: Re: {RFC PATCH v1 v4.11-rc1 1/1} acpi: apei: common handler in
> ghes for HW errors notified via hed(PNP0C33) driver
> 
> Hi Shiju,
> 
> On 07/03/17 16:07, Shiju Jose wrote:
> > Add common handler in ghes for HW errors notified via hed(PNP0C33)
> driver.
> > 1. Rename ghes_notify_sci() to ghes_notify_hed().
> > 2. Rename struct notifier_block ghes_notifier_sci to
> >    struct notifier_block ghes_notifier_hed.
> > 3. Rename ghes_sci list to ghes_hed.
> > 4. Make ghes_notify_hed as common handler for
> >    notification types SCI, GSIV and GPIO.
> >
> 
> I think the code here is fine, but we need to put this in front of the
> ACPI maintainers, and if we can, make their job easy.
> 
> How did you come up with the CC list for this patch?
> scripts/get_maintainer.pl
> lists:
> > "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > (supporter:ACPI,commit_signer:2/4=50%)
> > Len Brown <lenb@kernel.org> (supporter:ACPI)
> 
> as the maintainers for the file changed by this patch, but they weren't
> CCd.
Ok. I will post the patch CC ACPI maintainers.
> 
> Did you use git format-patch to create this? All the other patches on
> the list have subjects of the form "[PATCH] acpi: apei....", the {}s
> confuse 'git am'
> meaning whoever applies this would have to edit your patch before
> applying it.
Ok. I got it. I will correct in next patch. I used git format-patch to create the patch.  
> 
> 
> Your commit message doesn't add anything that wasn't in the subject-
> line. It should describe the reason for the change. Based on Hanjun's
> explanation I can
> offer:
> ---
> System Controller Interrupts are received by ACPI's error device, which
> in turn notifies the GHES code. The same is true of APEI's GSIV and
> GPIO notification types.
> Add support for GSIV and GPIO sharing the SCI
> register/unregister/notifier code.
> Rename the list and notifier to show this is no longer just SCI, but
> anything from the Hardware Error Device.
sure. I will correct the commit message.  

> 
> ---
> 
> If you're confident you solved this the right way, (which I think we
> are), you should drop the 'RFC' from the subject. RFC indicates you
> don't think this should be merged you just want feedback.
This patch was posted for feedback. I will post the next version of the patch with RFC removed.  
> 
> 
> 
> Thanks,
> 
> James
> 
> 
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index
> > b192b42..fd39929 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -89,14 +89,14 @@
> >  module_param_named(disable, ghes_disable, bool, 0);
> >
> >  /*
> > - * All error sources notified with SCI shares one notifier function,
> > + * All error sources notified with HED shares one notifier function,
> >   * so they need to be linked and checked one by one.  This is
> applied
> >   * to NMI too.
> >   *
> >   * RCU is used for these lists, so ghes_list_mutex is only used for
> >   * list changing, not for traversing.
> >   */
> > -static LIST_HEAD(ghes_sci);
> > +static LIST_HEAD(ghes_hed);
> >  static DEFINE_MUTEX(ghes_list_mutex);
> >
> >  /*
> > @@ -702,14 +702,14 @@ static irqreturn_t ghes_irq_func(int irq, void
> *data)
> >  	return IRQ_HANDLED;
> >  }
> >
> > -static int ghes_notify_sci(struct notifier_block *this,
> > +static int ghes_notify_hed(struct notifier_block *this,
> >  				  unsigned long event, void *data)  {
> >  	struct ghes *ghes;
> >  	int ret = NOTIFY_DONE;
> >
> >  	rcu_read_lock();
> > -	list_for_each_entry_rcu(ghes, &ghes_sci, list) {
> > +	list_for_each_entry_rcu(ghes, &ghes_hed, list) {
> >  		if (!ghes_proc(ghes))
> >  			ret = NOTIFY_OK;
> >  	}
> > @@ -718,8 +718,8 @@ static int ghes_notify_sci(struct notifier_block
> *this,
> >  	return ret;
> >  }
> >
> > -static struct notifier_block ghes_notifier_sci = {
> > -	.notifier_call = ghes_notify_sci,
> > +static struct notifier_block ghes_notifier_hed = {
> > +	.notifier_call = ghes_notify_hed,
> >  };
> >
> >  #ifdef CONFIG_HAVE_ACPI_APEI_NMI
> > @@ -966,6 +966,8 @@ static int ghes_probe(struct platform_device
> *ghes_dev)
> >  	case ACPI_HEST_NOTIFY_POLLED:
> >  	case ACPI_HEST_NOTIFY_EXTERNAL:
> >  	case ACPI_HEST_NOTIFY_SCI:
> > +	case ACPI_HEST_NOTIFY_GSIV:
> > +	case ACPI_HEST_NOTIFY_GPIO:
> >  		break;
> >  	case ACPI_HEST_NOTIFY_NMI:
> >  		if (!IS_ENABLED(CONFIG_HAVE_ACPI_APEI_NMI)) { @@ -1026,10
> +1028,12
> > @@ static int ghes_probe(struct platform_device *ghes_dev)
> >  		}
> >  		break;
> >  	case ACPI_HEST_NOTIFY_SCI:
> > +	case ACPI_HEST_NOTIFY_GSIV:
> > +	case ACPI_HEST_NOTIFY_GPIO:
> >  		mutex_lock(&ghes_list_mutex);
> > -		if (list_empty(&ghes_sci))
> > -			register_acpi_hed_notifier(&ghes_notifier_sci);
> > -		list_add_rcu(&ghes->list, &ghes_sci);
> > +		if (list_empty(&ghes_hed))
> > +			register_acpi_hed_notifier(&ghes_notifier_hed);
> > +		list_add_rcu(&ghes->list, &ghes_hed);
> >  		mutex_unlock(&ghes_list_mutex);
> >  		break;
> >  	case ACPI_HEST_NOTIFY_NMI:
> > @@ -1068,10 +1072,12 @@ static int ghes_remove(struct platform_device
> *ghes_dev)
> >  		free_irq(ghes->irq, ghes);
> >  		break;
> >  	case ACPI_HEST_NOTIFY_SCI:
> > +	case ACPI_HEST_NOTIFY_GSIV:
> > +	case ACPI_HEST_NOTIFY_GPIO:
> >  		mutex_lock(&ghes_list_mutex);
> >  		list_del_rcu(&ghes->list);
> > -		if (list_empty(&ghes_sci))
> > -			unregister_acpi_hed_notifier(&ghes_notifier_sci);
> > +		if (list_empty(&ghes_hed))
> > +			unregister_acpi_hed_notifier(&ghes_notifier_hed);
> >  		mutex_unlock(&ghes_list_mutex);
> >  		break;
> >  	case ACPI_HEST_NOTIFY_NMI:
> >
