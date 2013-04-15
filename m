From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Mon, 15 Apr 2013 22:34:00 +0530
Subject: [PATCH 3/3] driver: net: ethernet: cpsw: dual emac interface
 implementation
In-Reply-To: <516B016F.3020308@mimc.co.uk>
References: <1360612340-9266-1-git-send-email-mugunthanvnm@ti.com>
 <1360612340-9266-4-git-send-email-mugunthanvnm@ti.com>
 <516B016F.3020308@mimc.co.uk>
Message-ID: <516C3300.10005@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/15/2013 12:50 AM, Mark Jackson wrote:
> On 11/02/13 19:52, Mugunthan V N wrote:
>> The CPSW switch can act as Dual EMAC by segregating the switch ports
>> using VLAN and port VLAN as per the TRM description in
>> 14.3.2.10.2 Dual Mac Mode
>>
>> Following CPSW components will be common for both the interfaces.
>> * Interrupt source is common for both eth interfaces
>> * Interrupt pacing is common for both interfaces
>> * Hardware statistics is common for all the ports
>> * CPDMA is common for both eth interface
>> * CPTS is common for both the interface and it should not be enabled on
>>    both the interface as timestamping information doesn't contain port
>>    information.
>>
>> Constrains
>> * Reserved VID of One port should not be used in other interface 
>> which will
>>    enable switching functionality
>> * Same VID must not be used in both the interface which will enable 
>> switching
>>    functionality
>>
>> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
>> ---
>
>> @@ -1237,6 +1372,18 @@ static int cpsw_probe_dt(struct 
>> cpsw_platform_data *data,
>>           if (mac_addr)
>>               memcpy(slave_data->mac_addr, mac_addr, ETH_ALEN);
>>
>> +        if (data->dual_emac) {
>> +            if (of_property_read_u32(node, "dual_emac_res_vlan",
>> +                         &prop)) {
>
> Shouldn't this be:-
>
>     if (of_property_read_u32(slave_node, "dual_emac_res_vlan",
>                                  ^^^^^^^^^^
>
> ... so we pick each VLAN id from the individual slaves ?

Good catch, will send a fixup patch for this.

Regards
Mugunthan V N
