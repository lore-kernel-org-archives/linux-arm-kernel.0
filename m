From: collinsd@codeaurora.org (David Collins)
Date: Mon, 28 Mar 2011 11:22:22 -0700
Subject: [PATCH 1/2] regulator: Remove possible deadlock from
	regulator_enable
In-Reply-To: <20110328181151.GB28494@opensource.wolfsonmicro.com>
References: <1301326482-6547-1-git-send-email-collinsd@codeaurora.org>
	<1301326482-6547-2-git-send-email-collinsd@codeaurora.org>
	<20110328181151.GB28494@opensource.wolfsonmicro.com>
Message-ID: <4D90D1DE.2030202@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2011 11:11 AM, Mark Brown wrote:

>> -/* locks held by regulator_enable() */
>> +/* Locks are *not* held by regulator_enable(). */
>>  static int _regulator_enable(struct regulator_dev *rdev)
>>  {
>> -	int ret, delay;
>> +	struct regulator_dev *supply_rdev = NULL;
>> +	int ret = 0, delay;
>>  
>> +	mutex_lock(&rdev->mutex);
> 
> This is going to be terribly confusing - the _ versions of the functions
> all by convention rely on their callers taking the mutex, allowing them
> to be safely used from internal APIs.  

_regulator_enable is only being called within regulator_enable and
_regulator_enable.  Would it remove the confusion to rename
_regulator_enable to something different?

-David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
