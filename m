From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 30 Jun 2015 17:00:53 +0200
Subject: [PATCH 08/13] gpio: sysfs: implement class.get_dependencies()
In-Reply-To: <20150617174009.GZ14071@sirena.org.uk>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
 <1434548543-22949-9-git-send-email-tomeu.vizoso@collabora.com>
 <20150617174009.GZ14071@sirena.org.uk>
Message-ID: <CAAObsKDYvgxuxH0ZpXaTrsjLYOaZ-W_evOWfLLTNFRFYMra5LQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 June 2015 at 19:40, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Jun 17, 2015 at 03:42:18PM +0200, Tomeu Vizoso wrote:
>
>> +static bool strends(const char *str, const char *postfix)
>> +{
>> +     if (strlen(str) < strlen(postfix))
>> +             return false;
>> +
>> +     return strcmp(str + strlen(str) - strlen(postfix), postfix) == 0;
>> +}
>
> This is named like (and looks like) a generic fuction, shouldn't it be
> in string.h or something?

Yeah, will put it there.

>> +static void add_dependency(struct fwnode_handle *fwnode,
>> +                        struct list_head *list)
>> +{
>> +     struct fwnode_dependency *dep;
>> +
>> +     dep = kzalloc(sizeof(*dep), GFP_KERNEL);
>> +     if (!dep)
>> +             return;
>> +
>> +     INIT_LIST_HEAD(&dep->dependency);
>> +     dep->fwnode = fwnode;
>> +
>> +     list_add_tail(&dep->dependency, list);
>> +}
>
> Might be worth putting this in generic code, it looks pretty generic?  I
> have to say I'm unclear what frees the returned list.

Agreed.

>> +     if (!is_of_node(fwnode))
>> +             return NULL;
>> +
>> +     np = of_node(fwnode);
>> +     if (!np)
>> +             return NULL;
>
> Presumably the first check could be dropped?

That's right.

>> +     list = kzalloc(sizeof(*list), GFP_KERNEL);
>> +     if (!list)
>> +             return NULL;
>
> Might it make sense for the core to allocate the head of the list and
> just ask the classes to add to the list?  We're going to want to merge
> the dependencies from multiple subsystems and that saves allocating
> heads that may never get anything added to them.

Yes, I have gone with that advice and it looks better that way.

Thanks,

Tomeu
