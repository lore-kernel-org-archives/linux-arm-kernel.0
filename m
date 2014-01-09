From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 08 Jan 2014 18:24:16 -0800
Subject: [PATCH v3 4/7] mfd: ssbi: Add regmap read/write helpers
In-Reply-To: <20140109011327.GC23276@sonymobile.com>
References: <1389206270-3728-1-git-send-email-sboyd@codeaurora.org>
 <1389206270-3728-5-git-send-email-sboyd@codeaurora.org>
 <20140109011327.GC23276@sonymobile.com>
Message-ID: <52CE0850.4010206@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/14 17:13, Courtney Cavin wrote:
> On Wed, Jan 08, 2014 at 07:37:47PM +0100, Stephen Boyd wrote:
>> --- a/include/linux/ssbi.h
>> +++ b/include/linux/ssbi.h
>> @@ -20,4 +20,17 @@
>>  int ssbi_write(struct device *dev, u16 addr, const u8 *buf, int len);
>>  int ssbi_read(struct device *dev, u16 addr, u8 *buf, int len);
>>  
>> +static inline int
>> +ssbi_reg_read(void *context, unsigned int reg, unsigned int *val)
>> +{
>> +	*val = 0;
>> +	return ssbi_read(context, reg, (u8 *)val, 1);
>> +}
>> +
>> +static inline int
>> +ssbi_reg_write(void *context, unsigned int reg, unsigned int val)
>> +{
>> +	return ssbi_write(context, reg, (u8 *)&val, 1);
>> +}
> These functions are endian specific and just generally ugly. I
> understand that these functions may make the ssbi regmap code cleaner,
> but that's not really a good excuse for functions which by themselves
> look horribly broken.
>
> If these are really needed, perhaps something like the following would
> be acceptable?
>
> +static inline int
> +ssbi_reg_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	int rc;
> +	u8 b;
> +	rc = ssbi_read(context, reg, &b, 1);
> +	if (rc == 1)
> +		*val = b;
> +	return rc;
> +}
> +
> +static inline int
> +ssbi_reg_write(void *context, unsigned int reg, unsigned int val)
> +{
> +	u8 b = val;
> +	return ssbi_write(context, reg, &b, 1);
> +}

Sure. I think you meant to check for a 0 return value from ssbi_read
though? Lee can you use this replacement patch please?

---8<---
From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] mfd: ssbi: Add regmap read/write helpers

Add read and write helper functions that the pm8921-core driver
can use to read and write ssbi regsiters via a "no-bus" regmap.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 include/linux/ssbi.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/ssbi.h b/include/linux/ssbi.h
index bcbb642a7641..087b08a4d333 100644
--- a/include/linux/ssbi.h
+++ b/include/linux/ssbi.h
@@ -20,4 +20,24 @@
 int ssbi_write(struct device *dev, u16 addr, const u8 *buf, int len);
 int ssbi_read(struct device *dev, u16 addr, u8 *buf, int len);
 
+static inline int
+ssbi_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	int ret;
+	u8 v;
+
+	ret = ssbi_read(context, reg, &v, 1);
+	if (!ret)
+		*val = v;
+
+	return ret;
+}
+
+static inline int
+ssbi_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	u8 v = val;
+	return ssbi_write(context, reg, &v, 1);
+}
+
 #endif

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
