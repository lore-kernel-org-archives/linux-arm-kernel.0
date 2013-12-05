From: stefan@agner.ch (Stefan Agner)
Date: Thu, 05 Dec 2013 23:56:39 +0100
Subject: [PATCH v4 1/3] mfd: tps6586x: add version detection
In-Reply-To: <52A0BA85.4020201@wwwdotorg.org>
References: <cover.1386108712.git.stefan@agner.ch>
 <77384d24810d9a22fc04cad6f7468f54a9cbaafe.1386108712.git.stefan@agner.ch>
 <52A0B2AF.60803@wwwdotorg.org> <b2a1db4167d319d355dd2a3a844553bc@agner.ch>
 <52A0BA85.4020201@wwwdotorg.org>
Message-ID: <ac11b85d05765b3b68eff8c27041e965@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 2013-12-05 18:40, schrieb Stephen Warren:
> On 12/05/2013 10:43 AM, Stefan Agner wrote:
>> Am 2013-12-05 18:06, schrieb Stephen Warren:
>> <snip>
>>>> @@ -493,13 +527,12 @@ static int tps6586x_i2c_probe(struct i2c_client *client,
>>>>  		return -EIO;
>>>>  	}
>>>>
>>>> -	dev_info(&client->dev, "VERSIONCRC is %02x\n", ret);
>>>> -
>>>>  	tps6586x = devm_kzalloc(&client->dev, sizeof(*tps6586x), GFP_KERNEL);
>>>> -	if (tps6586x == NULL) {
>>>> -		dev_err(&client->dev, "memory for tps6586x alloc failed\n");
>>>> +	if (!tps6586x)
>>>>  		return -ENOMEM;
>>>> -	}
>>>> +
>>>> +	tps6586x->version = ret;
>>>
>>> I have to say, I dislike this version of the patch. Separating the
>>> reading of the version register from the assignment to tps6586x->version
>>> doesn't make any sense, especially given that the version value is
>>> stored in a variable named "ret"; that name isn't remotely related to
>>> what's stored there. What if someone comes along later and adds more
>>> code that assigns to ret between where it's repurposed for the version
>>> value and where it's assigned to tps6586x->version? It'd be extremely
>>> difficult for a patch reviewer to spot that given the limited context in
>>> a diff, and quite non-obvious to the person changing the code too..
>>
>> The value comes from the return value of i2c_smbus_read_byte_data. If
>> the value is below zero its an EIO error.
>>
>> I could add a variable "version", but for me it felt strange because we
>> check if version is below zero. This feels like its a wrong version
>> rather than a transmit error. So I would prefer ret over version. But I
>> agree, when one just reads the patch, its not obvious what exactly
>> happens.
> 
> In my opinion, using a variable named "version" here would be
> preferable. Testing that against <0 is just the way the I2C API works,
> so the same argument could be applied to any I2C access.

Hm, I try the empiric way:

$ grep -r -e i2c_smbus_read_byte_data | grep "ret =" | wc -l
139
$ grep -r -e i2c_smbus_read_byte_data | grep "version =" | wc -l
3

Ok, thats not fair at all, version is usage specific whilst ret is not.

$ grep -r -e i2c_smbus_read_byte_data | grep " = " | wc -l
703

On the other hand is the additional variable. But I think the compiler
will optimize that anyway, so this might not be an argument at all :-)

I see your point... Should I create another patch revision? Lee, is the
patch already merged?
