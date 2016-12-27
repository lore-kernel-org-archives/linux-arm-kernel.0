From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Tue, 27 Dec 2016 09:49:57 +0530
Subject: [RFC PATCH 1/7] PF driver modified to enable HW filter support,
 changes works in backward compatibility mode Enable required things in
 Makefile Enable LZ4 dependecy inside config file
In-Reply-To: <DM5PR07MB28428EE7B1679FAEC78103AD8D960@DM5PR07MB2842.namprd07.prod.outlook.com>
References: <1482310011-1862-1-git-send-email-satha.rao@caviumnetworks.com>
 <1482310011-1862-2-git-send-email-satha.rao@caviumnetworks.com>
 <CA+sq2CfwTN5u6nhxriqWqoFxsYHdEYikbjBgMCL2YwNXpqyQ=Q@mail.gmail.com>
 <DM5PR07MB28428EE7B1679FAEC78103AD8D960@DM5PR07MB2842.namprd07.prod.outlook.com>
Message-ID: <CA+sq2Cc0L3hqV_TUxtf00-UnUs8gMJfjL7bZaGejGevDYn6mPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>  #define NIC_MAX_RSS_HASH_BITS          8
>>  #define NIC_MAX_RSS_IDR_TBL_SIZE       (1 << NIC_MAX_RSS_HASH_BITS)
>> +#define NIC_TNS_RSS_IDR_TBL_SIZE       5
>
> So you want to use only 5 queues per VF when TNS is enabled, is it ??
> There are 4096 RSS indices in total, for each VF you can use max 32.
> I guess you wanted to set no of hash bits to 5 instead of table size.
>
> SATHA>>> We enabled 8 queues for VF. Yes Macro name misleads it has to be hash bits, will change this in next version

No, I am not referring to any discrepancy in naming the macro.
If you check your code

- hw->rss_ind_tbl_size = NIC_MAX_RSS_IDR_TBL_SIZE;
+ hw->rss_ind_tbl_size = veb_enabled ? NIC_TNS_RSS_IDR_TBL_SIZE :
+     NIC_MAX_RSS_IDR_TBL_SIZE;

You are setting RSS table size to 5, i.e RSS hash bits will be set to 2.
Hence only 4 queues (not even 5 as i mentioned earlier). Please check
'nicvf_rss_init' you will understand what i am saying.
Have you tested and observed pkts in all 8 queues ?
