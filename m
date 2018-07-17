From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 17 Jul 2018 15:26:45 +0100
Subject: [PATCH] arm64: fix kernel panic on serror exception caused by
 user process
In-Reply-To: <CAM5rFu8avWLrUhEsCHBTKv=sM6dE3Sh_0=5M3Eh0WcT9EdmtSg@mail.gmail.com>
References: <1531819881-2931-1-git-send-email-hari.vyas@broadcom.com>
 <1531819881-2931-2-git-send-email-hari.vyas@broadcom.com>
 <20180717100628.s5emikyc6orira2q@lakrids.cambridge.arm.com>
 <CAM5rFu_trZpt20H2GAUq8GYTOuJMSmEknsQaEkPkDwFHPVDPeA@mail.gmail.com>
 <20180717114815.5a3rbcznfzvi2xh6@lakrids.cambridge.arm.com>
 <CAM5rFu8avWLrUhEsCHBTKv=sM6dE3Sh_0=5M3Eh0WcT9EdmtSg@mail.gmail.com>
Message-ID: <9b9c4cd5-4428-c08d-d4a3-7352c6c80583@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/07/18 14:40, Hari Vyas wrote:
[...]
>> Sorry, but this is simply a risk of exposing /dev/mem to userspace.
>>
>> The user could also use devmem to poke devices in ways which could
>> permanently damage them. If you cannot trust the user to not do such
>> things, you must not give them access to /dev/mem.
>>
> Okay. Don't think it is a question of trust. If access happens from
> kernel mode, I understand but If user mode initiated
> access(from devmem(which is just an example) or any other application)
> into outside or invalid region of system
> address brings complete kernel down, at least I will be surprised.

If you have an Arm Juno board, why not try this fun little demonstration 
I once wrote for a colleague:


#include <fcntl.h>
#include <sys/mman.h>

int main(void) {
	int *dmc, fd = open("/dev/mem", O_RDWR|O_SYNC);
	
	dmc = mmap(0, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0x2b0a0000);
	dmc[2] = 1;
}


The simple fact is that anyone with access to /dev/mem *can* take down 
the system any number of ways. It's foolish to think there's any way of 
protecting against that other than by not giving them access at all.

Robin.


[ For anyone interested, it puts the DRAM controller into sleep mode. 
The kernel can't even panic if all the memory suddenly disappears :D ]
