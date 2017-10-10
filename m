From: ddaney@caviumnetworks.com (David Daney)
Date: Tue, 10 Oct 2017 14:37:51 -0700
Subject: [PATCH v2] xdp: Sample xdp program implementing ip forward
In-Reply-To: <20171010101921.30136d48@shemminger-XPS-13-9360>
References: <1507620532-25804-1-git-send-email-Christina.Jacob@cavium.com>
 <1507620532-25804-2-git-send-email-Christina.Jacob@cavium.com>
 <20171010101921.30136d48@shemminger-XPS-13-9360>
Message-ID: <d73a1229-7bb2-873c-932e-61430847ba3a@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/2017 10:19 AM, Stephen Hemminger wrote:
> On Tue, 10 Oct 2017 12:58:52 +0530
> Christina Jacob <christina.jacob.koikara@gmail.com> wrote:
> 
>> +/* Get the mac address of the interface given interface name */
>> +static long *getmac(char *iface)
>> +{
>> +	int fd;
>> +	struct ifreq ifr;
>> +	long *mac = NULL;
>> +
>> +	fd = socket(AF_INET, SOCK_DGRAM, 0);
>> +	ifr.ifr_addr.sa_family = AF_INET;
>> +	strncpy(ifr.ifr_name, iface, IFNAMSIZ - 1);
>> +	ioctl(fd, SIOCGIFHWADDR, &ifr);
>> +	mac = (long *)ifr.ifr_hwaddr.sa_data;
>> +	close(fd);
>> +	return mac;
> 
> Always check return value of ioctl.
> You are assuming sizeof(long) > 6 bytes.
> Also the byte order.


Also:

Returning the address of a local variable (ifr.ifr_hwaddr.sa_data), and 
then dereferencing it outside of the function is not correct.

The casting of the char sa_data[] to a long * may cause alignment faults 
on some architectures.  The may also be endinaness issues depending on 
how the data are manipulated if you pack all those chars into a long.

If we think that a MAC address is char[6], then it may be best to define 
the data structures as such and manipulate it as an array instead of 
trying to pack it into a long.

Keep working on this though, this program will surely be useful.

David Daney
