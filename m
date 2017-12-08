From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 8 Dec 2017 09:33:27 -0500
Subject: [PATCH V6 4/7] OF: properties: Implement get_match_data() callback
In-Reply-To: <20171208101142.1ea9bc13@karo-electronics.de>
References: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
 <1512493493-6464-5-git-send-email-okaya@codeaurora.org>
 <20171207141029.575c0a03@karo-electronics.de>
 <def8e351-bc2d-7adc-fdc5-362b365302a8@codeaurora.org>
 <20171207162036.6a71a4f5@karo-electronics.de>
 <661cbe4d-ea33-3e84-b5f2-ab6517cbb135@codeaurora.org>
 <20171208101142.1ea9bc13@karo-electronics.de>
Message-ID: <6a47c4f6-096e-626d-6761-5f88a07609a7@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/8/2017 4:11 AM, Lothar Wa?mann wrote:
>> While implementing the ACPI piece, I have to convert an unsigned long to
>> (const void *) in ACPI code so that the APIs are compatible.
>>
> Just one more remark: Do you need write access to the data the pointer
> returned by device_get_match_data() or of_fwnode_get_match_data()
> points to?
> If not, the return type of those functions should be 'const void *'.

Yes, the only reason driver is trying to obtain this data pointer is to modify
members of it. I did a quick test with your suggestion.

test.c: In function ?main?:
test.c:15:2: error: assignment of member ?m? in read-only object
  t->m = 3;
  ^

struct test
{
        int m;
};

int main(void)
{
        const void *ptr;
        unsigned long l =4;
        const struct test *t;

        ptr = (const void *)l;

        t = ptr;
        t->m = 3;
}



-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
