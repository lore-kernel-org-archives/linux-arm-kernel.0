From: javierm@redhat.com (Javier Martinez Canillas)
Date: Tue, 19 Jun 2018 22:54:45 +0200
Subject: [RFC PATCH v2] driver core: add a debugfs entry to show deferred
 devices
In-Reply-To: <CAHp75VdpHdanWJmcwLBRTSDoDkbpPxuAGwwVO0hosXSRn4PUoA@mail.gmail.com>
References: <20180619183356.32106-1-javierm@redhat.com>
 <CAHp75Vcn39N9rZ0UO3szGrODVLxek4X746uWs+RPXwy4i0s1Ug@mail.gmail.com>
 <CAHp75VdpHdanWJmcwLBRTSDoDkbpPxuAGwwVO0hosXSRn4PUoA@mail.gmail.com>
Message-ID: <c0003b93-886f-10d1-fd7b-17b0323b90a7@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andy,

Thanks a lot for your feedback.

On 06/19/2018 09:55 PM, Andy Shevchenko wrote:
> On Tue, Jun 19, 2018 at 10:53 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Tue, Jun 19, 2018 at 9:33 PM, Javier Martinez Canillas
>> <javierm@redhat.com> wrote:
>>> For debugging purposes it may be useful to know what are the devices whose
>>> probe function was deferred. Add a debugfs entry showing that information.
> 
>>> +static int deferred_devs_open(struct inode *inode, struct file *file)
>>> +{
>>> +       return single_open(file, deferred_devs_show, inode->i_private);
>>> +}
>>> +
>>> +static const struct file_operations deferred_devs_fops = {
>>> +       .owner = THIS_MODULE,
>>> +       .open = deferred_devs_open,
>>> +       .read = seq_read,
>>> +       .llseek = seq_lseek,
>>> +       .release = single_release,
>>> +};
>>
>> Isn't this DEFINE_SHOW_ATTRIBUTE() ?
>

Indeed.
 
> Besides that, you are summoning Greg's dark side :-)
> See below.
> 
>>> +       if (IS_ENABLED(CONFIG_DEBUG_FS)) {
>>> +               deferred_devices = debugfs_create_file("deferred_devices",
>>> +                                                      0444, NULL, NULL,
>>> +                                                      &deferred_devs_fops);
> 
>>> +               if (!deferred_devices)
>>> +                       return -ENOMEM;
> 
> This must not prevent the execution. So, the check introduces actually
> a regression.
>

Fair enough, I'll fix these an re-spin the patch.
 
>>> +       }
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
