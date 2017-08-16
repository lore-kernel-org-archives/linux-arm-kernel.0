From: frowand.list@gmail.com (Frank Rowand)
Date: Wed, 16 Aug 2017 14:56:00 -0700
Subject: [patch net-next 1/3] idr: Use unsigned long instead of int
In-Reply-To: <1502849538-14284-2-git-send-email-chrism@mellanox.com>
References: <1502849538-14284-1-git-send-email-chrism@mellanox.com>
 <1502849538-14284-2-git-send-email-chrism@mellanox.com>
Message-ID: <5994BF70.4040203@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I replied to patch 0/3 when I to trim the distribution list.  I meant to
reply to patch 1/3.


On 08/16/17 14:51, Frank Rowand wrote:
> I deleted most of the distribution list.  My email server rejects an email
> with this many recipients.
> 
> 
> On 08/15/17 19:12, Chris Mi wrote:
>> IDR uses internally radix tree which uses unsigned long. It doesn't
>> makes sense to have index as signed value.
>>
>> Signed-off-by: Chris Mi <chrism@mellanox.com>
>> Signed-off-by: Jiri Pirko <jiri@mellanox.com>
>> ---
> 
> < snip >
> 
>>  drivers/of/overlay.c                            | 15 +++----
>>  drivers/of/unittest.c                           | 25 ++++++-----
> 
> < snip >
> 
>>  include/linux/of.h                              |  4 +-
> 
> < snip >
> 
> Split the patch apart.
> 
> 
>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>> index c0e4ee1..e5cfe01 100644
>> --- a/drivers/of/overlay.c
>> +++ b/drivers/of/overlay.c
>> @@ -373,10 +373,11 @@ static int of_free_overlay_info(struct of_overlay *ov)
>>   *
>>   * Returns the id of the created overlay, or a negative error number
>>   */
>> -int of_overlay_create(struct device_node *tree)
>> +int of_overlay_create(struct device_node *tree, unsigned long *id)
> 
> Added parameter *id, but never assigned a value to it.
> 
>>  {
>>  	struct of_overlay *ov;
>> -	int err, id;
>> +	unsigned long idr_index;
>> +	int err;
>>  
>>  	/* allocate the overlay structure */
>>  	ov = kzalloc(sizeof(*ov), GFP_KERNEL);
>> @@ -390,12 +391,10 @@ int of_overlay_create(struct device_node *tree)
>>  
>>  	mutex_lock(&of_mutex);
>>  
>> -	id = idr_alloc(&ov_idr, ov, 0, 0, GFP_KERNEL);
>> -	if (id < 0) {
>> -		err = id;
>> +	err = idr_alloc(&ov_idr, ov, &idr_index, 0, 0, GFP_KERNEL);
>> +	if (err)
>>  		goto err_destroy_trans;
>> -	}
>> -	ov->id = id;
>> +	ov->id = idr_index;
>>  
>>  	/* build the overlay info structures */
>>  	err = of_build_overlay_info(ov, tree);
>> @@ -430,7 +429,7 @@ int of_overlay_create(struct device_node *tree)
>>  
>>  	mutex_unlock(&of_mutex);
>>  
>> -	return id;
>> +	return err;
>>  
>>  err_revert_overlay:
>>  err_abort_trans:
>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>> index 0107fc6..ac7cc76 100644
>> --- a/drivers/of/unittest.c
>> +++ b/drivers/of/unittest.c
>> @@ -1242,7 +1242,8 @@ static int of_unittest_apply_overlay(int overlay_nr, int unittest_nr,
>>  		int *overlay_id)
>>  {
>>  	struct device_node *np = NULL;
>> -	int ret, id = -1;
>> +	unsigned long id = -1;
> 
> Assigns a negative value to an unsigned.
> 
> 
>> +	int ret;
>>  
>>  	np = of_find_node_by_path(overlay_path(overlay_nr));
>>  	if (np == NULL) {
>> @@ -1252,17 +1253,14 @@ static int of_unittest_apply_overlay(int overlay_nr, int unittest_nr,
>>  		goto out;
>>  	}
>>  
>> -	ret = of_overlay_create(np);
>> -	if (ret < 0) {
>> +	ret = of_overlay_create(np, &id);
>> +	if (ret) {
>>  		unittest(0, "could not create overlay from \"%s\"\n",
>>  				overlay_path(overlay_nr));
>>  		goto out;
>>  	}
>> -	id = ret;
>>  	of_unittest_track_overlay(id);
>>  
>> -	ret = 0;
>> -
>>  out:
>>  	of_node_put(np);
>>  
>> @@ -1442,6 +1440,7 @@ static void of_unittest_overlay_6(void)
>>  	int ret, i, ov_id[2];
>>  	int overlay_nr = 6, unittest_nr = 6;
>>  	int before = 0, after = 1;
>> +	unsigned long id;
>>  
>>  	/* unittest device must be in before state */
>>  	for (i = 0; i < 2; i++) {
>> @@ -1466,13 +1465,13 @@ static void of_unittest_overlay_6(void)
>>  			return;
>>  		}
>>  
>> -		ret = of_overlay_create(np);
>> -		if (ret < 0)  {
>> +		ret = of_overlay_create(np, &id);
>> +		if (ret)  {
>>  			unittest(0, "could not create overlay from \"%s\"\n",
>>  					overlay_path(overlay_nr + i));
>>  			return;
>>  		}
>> -		ov_id[i] = ret;
>> +		ov_id[i] = id;
>>  		of_unittest_track_overlay(ov_id[i]);
>>  	}
>>  
>> @@ -2094,6 +2093,7 @@ static int __init overlay_data_add(int onum)
>>  	int ret;
>>  	u32 size;
>>  	u32 size_from_header;
>> +	unsigned long id;
>>  
>>  	for (k = 0, info = overlays; info; info++, k++) {
>>  		if (k == onum)
>> @@ -2138,13 +2138,12 @@ static int __init overlay_data_add(int onum)
>>  		goto out_free_np_overlay;
>>  	}
>>  
>> -	ret = of_overlay_create(info->np_overlay);
>> -	if (ret < 0) {
>> +	ret = of_overlay_create(info->np_overlay, &id);
>> +	if (ret) {
>>  		pr_err("of_overlay_create() (ret=%d), %d\n", ret, onum);
>>  		goto out_free_np_overlay;
>>  	} else {
>> -		info->overlay_id = ret;
>> -		ret = 0;
>> +		info->overlay_id = id;
>>  	}
>>  
>>  	pr_debug("__dtb_overlay_begin applied, overlay id %d\n", ret);
> 
> 
> 
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index 4a8a709..ceb14bf 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -1307,7 +1307,7 @@ struct of_overlay_notify_data {
>>  #ifdef CONFIG_OF_OVERLAY
>>  
>>  /* ID based overlays; the API for external users */
>> -int of_overlay_create(struct device_node *tree);
>> +int of_overlay_create(struct device_node *tree, *unsigned long *id);
> 
> *unsigned long *id should be: unsigned long *id
> 
> How did you test this patch?
> 
> 
>>  int of_overlay_destroy(int id);
>>  int of_overlay_destroy_all(void);
>>  
>> @@ -1316,7 +1316,7 @@ struct of_overlay_notify_data {
>>  
>>  #else
>>  
>> -static inline int of_overlay_create(struct device_node *tree)
>> +static inline int of_overlay_create(struct device_node *tree, unsigned long *id)
>>  {
>>  	return -ENOTSUPP;
>>  }
> 
> 
> 
